import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gfi/layers/domain/entities/Actuator.dart';
import 'package:gfi/layers/domain/entities/Device.dart';
import 'package:gfi/layers/domain/entities/Device_2_Room.dart';
import 'package:gfi/layers/domain/entities/Room.dart';
import 'package:gfi/layers/domain/entities/Sensor.dart';
import 'package:gfi/layers/presentation/widgets/connect_device_box.dart';

class DeviceManagement extends StatefulWidget {
  const DeviceManagement({super.key});

  static const route_name = '/detect_devices';

  @override
  State<DeviceManagement> createState() => _DeviceManagementState();
}

class _DeviceManagementState extends State<DeviceManagement> {
  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Room room = ModalRoute.of(context)!.settings.arguments as Room;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            'Connect to Wifi',
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
              padding: EdgeInsets.all(16),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Is this the Wifi that you want to connect",
                  style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Available Devices',
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
            ConnectDeviceBox(
              title: 'GFI - Gas Controller v1.0',
              backgroundColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.primary,
              titleColor: Theme.of(context).colorScheme.secondary,
              detailColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/authenticate_device',
                  arguments: Device_2_Room(
                      device: Device(
                          name: 'GFI - Gas Controller v1.0',
                          image_url: 'assets/images/gas-bottle.png',
                          connectionCode: generateRandomString(20),
                          sensor: Sensor(value: 0, threshold: 450),
                          actuator: Actuator(mode: true, isOn: false),
                          password: '',
                          timestamp: DateTime.now()
                      ),
                      room: room),
                );
              },
            ),
            ConnectDeviceBox(
              title: 'GFI - Electric Controller v1.0',
              backgroundColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.primary,
              titleColor: Theme.of(context).colorScheme.secondary,
              detailColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/authenticate_device',
                  arguments: Device_2_Room(
                      device: Device(
                          name: 'GFI - Electric Controller v1.0',
                          image_url: 'assets/images/electricity.png',
                          connectionCode: generateRandomString(20),
                          sensor: Sensor(value: 0, threshold: 450),
                          actuator: Actuator(mode: true, isOn: false),
                          password: '',
                          timestamp: DateTime.now()
                      ),
                      room: room),
                );
              },
            ),
            ConnectDeviceBox(
              title: 'GFI - Thermostat v1.0',
              backgroundColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.primary,
              titleColor: Theme.of(context).colorScheme.secondary,
              detailColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/authenticate_device',
                  arguments: Device_2_Room(
                      device: Device(
                          name: 'GFI - Thermostat v1.0',
                          image_url: 'assets/images/thermometer.png',
                          connectionCode: generateRandomString(20),
                          sensor: Sensor(value: 0, threshold: 450),
                          actuator: Actuator(mode: true, isOn: false),
                          password: '',
                          timestamp: DateTime.now()
                      ),
                      room: room),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
