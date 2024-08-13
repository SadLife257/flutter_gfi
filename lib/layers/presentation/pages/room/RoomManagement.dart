import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:gfi/layers/domain/entities/Device/Hardware.dart';
import 'package:gfi/layers/domain/entities/Hardware_2_Room.dart';
import 'package:gfi/layers/domain/entities/Room.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceScan.dart';
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
  final roomManagementKey = GlobalKey<FormState>();
  late List<Hardware> hardware;
  late Room room;

  @override
  void initState() {
    roomNameController = TextEditingController();
    super.initState();
  }

  Future<void> updateRoomName() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    String oldRoomName = room.name;
    String newRoomName = roomNameController.text.trim();
    room.name = newRoomName;

    //var roomID = await FirebaseFirestore.instance.collection('users_room').doc(userId);

    await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
      newRoomName: room.toJson()
    }).then((_) async {
      await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
        oldRoomName: FieldValue.delete()
      });
    });
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
        title: Text(AppLocalizations.of(context)!.room_delete_name(roomNameController.text.trim())),
        content: Text(AppLocalizations.of(context)!.confirm_required),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.tertiary,
            ),
            onPressed: () => Navigator.pop(context, AppLocalizations.of(context)!.cancel),
            child: Text(AppLocalizations.of(context)!.cancel),
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
            child: Text(AppLocalizations.of(context)!.confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)!.settings.arguments as Room;
    hardware = room.hardware.values.toList();
    roomNameController.text = room.name;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.room_management,
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
        body: Form(
          key: roomManagementKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: TextFormField(
                  controller: roomNameController,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.room_name,
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
                        onPressed: () {
                          if(roomManagementKey.currentState!.validate()) {
                            updateRoomName();
                          }
                        },
                        icon: Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.room_name_error_empty;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isEmptyInput = value.isEmpty;
                      roomNameController.text = value;
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
                        AppLocalizations.of(context)!.devices,
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
                itemCount: room.hardware.length,
                itemBuilder: (BuildContext context, int i) {
                  return DeviceBox(
                    title: hardware[i].name,
                    iconPath: hardware[i].image_url,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    borderColor: Theme.of(context).colorScheme.primary,
                    titleColor: Theme.of(context).colorScheme.secondary,
                    detailColor: Theme.of(context).colorScheme.primary,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onDeviceSetting: () {
                      Navigator.pushNamed(
                        context,
                        DeviceSetting.route_name,
                        arguments: Hardware_2_Room(hardware: hardware[i], room: room),
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
                      DeviceScan.route_name,
                      arguments: room,
                    );
                  },
                  child: Icon(
                      Icons.qr_code_scanner
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
