import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfi/layers/domain/entities/Device.dart';
import 'package:gfi/layers/domain/entities/Device_2_Room.dart';
import 'package:gfi/layers/domain/entities/Room.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceManagement.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceSetting.dart';
import 'package:gfi/layers/presentation/pages/room/RoomSetting.dart';
import 'package:gfi/layers/presentation/widgets/device_box.dart';

class RoomManagement extends StatefulWidget {
  const RoomManagement({super.key});

  static const route_name = '/manage_room';

  @override
  State<RoomManagement> createState() => _RoomManagementState();
}

class _RoomManagementState extends State<RoomManagement> {
  late final TextEditingController roomNameController;
  bool _isEmptyInput = true;
  late List<Device> devices;
  late Room room;

  @override
  void initState() {
    roomNameController = TextEditingController();
    super.initState();
  }

  Future<void> deleteRoom() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
      roomNameController.text.trim(): FieldValue.delete()
    });
  }

  void openSetting() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => RoomSetting()
    ).then((choice) {
      if(choice == 'delete'){
        deleteAlert();
      }
    });
  }

  void deleteAlert() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Delete ${roomNameController.text.trim()}'),
        content: Text('Please confirm'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.tertiary,
            ),
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              deleteRoom().then((_) {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              });
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)!.settings.arguments as Room;
    devices = room.devices.values.toList();
    roomNameController.text = room.name;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            'Room Management',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: 30,
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )
          ),
          actions: [
            IconButton(
                onPressed: openSetting,
                icon: Icon(
                  size: 30,
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                )
            )
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextFormField(
                controller: roomNameController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                ),
                decoration: InputDecoration(
                    labelText: 'Room Name',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    suffix: !_isEmptyInput ? IconButton(
                        alignment: Alignment.topRight,
                        onPressed: () {
                          roomNameController.clear();
                          setState(() {
                            _isEmptyInput = !_isEmptyInput;
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).colorScheme.primary,
                        )
                    ) : null,
                    suffixIcon: IconButton(
                      onPressed: () { /*Edit room name*/ },
                      icon: Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your room name";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _isEmptyInput = value.isEmpty;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Devices',
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: room.devices.length,
              itemBuilder: (BuildContext context, int i) {
                return DeviceBox(
                  title: devices[i].name,
                  iconPath: devices[i].image_url,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  borderColor: Theme.of(context).colorScheme.primary,
                  titleColor: Theme.of(context).colorScheme.secondary,
                  detailColor: Theme.of(context).colorScheme.primary,
                  iconColor: Theme.of(context).colorScheme.primary,
                  onDeviceSetting: () {
                    Navigator.pushNamed(
                      context,
                      DeviceSetting.route_name,
                      arguments: Device_2_Room(device: devices[i], room: room),
                    );
                  },
                );
              }
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: Size.fromHeight(75),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    DeviceManagement.route_name,
                    arguments: room,
                  );
                },
                child: Icon(
                    Icons.more_horiz
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
