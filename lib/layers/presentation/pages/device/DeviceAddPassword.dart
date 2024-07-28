import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gfi/layers/data/Device.dart';
import 'package:gfi/layers/data/Device_2_Room.dart';
import 'package:gfi/layers/data/Room.dart';

class DeviceAddPassword extends StatefulWidget {
  const DeviceAddPassword({super.key});

  static const route_name = '/authenticate_device';

  @override
  State<DeviceAddPassword> createState() => _DeviceAddPasswordState();
}

class _DeviceAddPasswordState extends State<DeviceAddPassword> {
  late final TextEditingController devicePasswordController;
  bool _isEmptyInput = true;
  bool _toggleObscurePassword = true;
  final devicePasswordKey = GlobalKey<FormState>();
  late Device device;
  late Room room;

  @override
  void initState() {
    devicePasswordController = TextEditingController();
    super.initState();
  }

  Future<void> addDevice() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    device.password = devicePasswordController.text.trim();

    room.devices[device.connectionCode] = device;
    room.timestamp = DateTime.now();

    await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
      room.name: room.toJson(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final Device_2_Room arg = ModalRoute.of(context)!.settings.arguments as Device_2_Room;
    room = arg.room;
    device = arg.device;

    return SafeArea(
      child: Scaffold(
          extendBody: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            centerTitle: true,
            title: Text(
              'Connect to Device',
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
            key: devicePasswordKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Enter password for ${device.name}",
                      style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 64),
                  child: TextFormField(
                    controller: devicePasswordController,
                    obscureText: _toggleObscurePassword,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                    ),
                    decoration: InputDecoration(
                        labelText: 'Device Password',
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
                              devicePasswordController.clear();
                              setState(() {
                                _isEmptyInput = !_isEmptyInput;
                              });
                            },
                            icon: const Icon(Icons.clear)
                        ) : null,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _toggleObscurePassword =
                                !_toggleObscurePassword;
                              });
                            },
                            icon: _toggleObscurePassword ? Icon(Icons.visibility, color: Theme.of(context).colorScheme.primary)
                                : Icon(Icons.visibility_off, color: Theme.of(context).colorScheme.primary)
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your device password";
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
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: Size.fromHeight(60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
                      ),
                    ),
                    onPressed: () {
                      if(devicePasswordKey.currentState!.validate()) {
                        addDevice().then((_) {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        });
                      }
                    },
                    child: Text(
                        'ADD'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: Size.fromHeight(60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                        'CANCEL'
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
