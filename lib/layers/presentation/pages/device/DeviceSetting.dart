import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:gfi/layers/domain/entities/Device/Hardware.dart';
import 'package:gfi/layers/domain/entities/Relation/Hardware_2_Room.dart';
import 'package:gfi/layers/domain/entities/Room/Room.dart';
import 'package:gfi/layers/presentation/widgets/notify_snackbar.dart';

class DeviceSetting extends StatefulWidget {
  final Hardware_2_Room hardware_2_room;

  DeviceSetting({
    super.key,
    required this.hardware_2_room,
  });

  static const route_name = '/device_setting';

  @override
  State<DeviceSetting> createState() => _DeviceSettingState();
}

class _DeviceSettingState extends State<DeviceSetting> {
  late final TextEditingController deviceNameController;
  final deviceSettingKey = GlobalKey<FormState>();
  bool _isEmptyInput = true;
  late String key;
  late Hardware hardware;
  late Room room;
  late FocusNode node;

  @override
  void initState() {
    deviceNameController = TextEditingController();
    node = FocusNode();
    key = widget.hardware_2_room.key;
    room = widget.hardware_2_room.room;
    hardware = widget.hardware_2_room.hardware;
    deviceNameController.text = hardware.name;
    super.initState();
  }

  Future<void> updateDeviceName() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    String newDeviceName = deviceNameController.text.trim();

    await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
      '${room.name}.hardware.$key.name': newDeviceName
    });
  }

  Future<void> deleteDevice() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    room.hardware.removeWhere((key, value) => value == hardware);
    //room.timestamp = DateTime.now();

    await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
      room.name: room.toJson()
    });
  }

  void deleteAlert() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.device_delete_name(deviceNameController.text.trim())),
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
              deleteDevice().then((_) {
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
  void dispose() {
    deviceNameController.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.device_setting,
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
        body: Form(
          key: deviceSettingKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: TextFormField(
                  focusNode: node,
                  controller: deviceNameController,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.device_name_label,
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
                        onPressed: () {
                          if(deviceSettingKey.currentState!.validate()) {
                            updateDeviceName().then((_) {
                              node.unfocus();
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(context).requestFocus(node);
                              });

                              CustomSnack.showNotifySnack(
                                context,
                                AppLocalizations.of(context)!.device_name_changed_success,
                                Icons.check,
                                Theme.of(context).colorScheme.primary,
                                Colors.green,
                              );
                            });
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
                      return AppLocalizations.of(context)!.device_name_error_empty;
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
              // InfoBox(
              //   title: 'Gas Detection',
              //   detail: '${device.sensor.value.round().toString()} / ${device.sensor.threshold.round().toString()}',
              //   backgroundColor: Theme.of(context).colorScheme.surface,
              //   borderColor: Theme.of(context).colorScheme.primary,
              //   titleColor: Theme.of(context).colorScheme.secondary,
              //   detailColor: Theme.of(context).colorScheme.primary,
              //   iconColor: Theme.of(context).colorScheme.primary,
              //   isChangeable: false,
              // ),
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
              // InfoBox(
              //   title: 'Mode',
              //   detail: '${device.actuator.mode ? 'auto' : 'manual'}',
              //   backgroundColor: Theme.of(context).colorScheme.surface,
              //   borderColor: Theme.of(context).colorScheme.primary,
              //   titleColor: Theme.of(context).colorScheme.secondary,
              //   detailColor: Theme.of(context).colorScheme.primary,
              //   iconColor: Theme.of(context).colorScheme.primary,
              //   isChangeable: false,
              // ),
              // InfoBox(
              //   title: 'State',
              //   detail: '${device.actuator.isOn ? 'on' : 'off'}',
              //   backgroundColor: Theme.of(context).colorScheme.surface,
              //   borderColor: Theme.of(context).colorScheme.primary,
              //   titleColor: Theme.of(context).colorScheme.secondary,
              //   detailColor: Theme.of(context).colorScheme.primary,
              //   iconColor: Theme.of(context).colorScheme.primary,
              //   isChangeable: false,
              // ),
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
                      AppLocalizations.of(context)!.delete,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
