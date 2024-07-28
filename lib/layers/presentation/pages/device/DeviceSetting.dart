import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfi/layers/data/Device.dart';
import 'package:gfi/layers/data/Device_2_Room.dart';
import 'package:gfi/layers/data/Room.dart';
import 'package:gfi/layers/presentation/widgets/info_box.dart';

class DeviceSetting extends StatefulWidget {
  const DeviceSetting({super.key});

  static const route_name = '/device_setting';

  @override
  State<DeviceSetting> createState() => _DeviceSettingState();
}

class _DeviceSettingState extends State<DeviceSetting> {
  late final TextEditingController deviceNameController;
  bool _isEmptyInput = true;
  late Device device;
  late Room room;

  @override
  void initState() {
    deviceNameController = TextEditingController();
    super.initState();
  }

  Future<void> deleteDevice() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    room.devices.removeWhere((key, value) => value == device);
    room.timestamp = DateTime.now();

    await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
      room.name: room.toJson()
    });
  }

  void deleteAlert() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Delete ${deviceNameController.text.trim()}'),
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
              deleteDevice().then((_) {
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
    final Device_2_Room arg = ModalRoute.of(context)!.settings.arguments as Device_2_Room;
    room = arg.room;
    device = arg.device;
    deviceNameController.text = device.name;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            'Device Setting',
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
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextFormField(
                controller: deviceNameController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                ),
                decoration: InputDecoration(
                    labelText: 'Device Name',
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
                          deviceNameController.clear();
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
              padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Sensor',
                      style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
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
            InfoBox(
              title: 'Data',
              detail: '${device.sensor.value.round().toString()} / ${device.sensor.threshold.round().toString()}',
              backgroundColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.primary,
              titleColor: Theme.of(context).colorScheme.secondary,
              detailColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              isChangeable: false,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Actuator',
                      style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
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
            InfoBox(
              title: 'Mode',
              detail: '${device.actuator.mode ? 'auto' : 'manual'}',
              backgroundColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.primary,
              titleColor: Theme.of(context).colorScheme.secondary,
              detailColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              isChangeable: false,
            ),
            InfoBox(
              title: 'State',
              detail: '${device.actuator.isOn ? 'on' : 'off'}',
              backgroundColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.primary,
              titleColor: Theme.of(context).colorScheme.secondary,
              detailColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              isChangeable: false,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: Size.fromHeight(60),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                  ),
                  onPressed: deleteAlert,
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: Text(
                    'Delete',
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
