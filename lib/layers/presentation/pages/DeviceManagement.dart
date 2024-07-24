import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/pages/DeviceAddPassword.dart';
import 'package:gfi/layers/presentation/widgets/connect_device_box.dart';

class DeviceManagement extends StatefulWidget {
  const DeviceManagement({super.key});

  @override
  State<DeviceManagement> createState() => _DeviceManagementState();
}

class _DeviceManagementState extends State<DeviceManagement> {
  late final TextEditingController deviceNameController;
  bool _isEmptyInput = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DeviceAddPassword())
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DeviceAddPassword())
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DeviceAddPassword())
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
