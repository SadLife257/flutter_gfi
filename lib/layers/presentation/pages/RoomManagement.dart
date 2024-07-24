import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/pages/DeviceManagement.dart';
import 'package:gfi/layers/presentation/widgets/device_box.dart';

class RoomManagement extends StatefulWidget {
  const RoomManagement({super.key});

  @override
  State<RoomManagement> createState() => _RoomManagementState();
}

class _RoomManagementState extends State<RoomManagement> {
  late final TextEditingController roomNameController;
  bool _isEmptyInput = true;

  @override
  void initState() {
    roomNameController = TextEditingController();
    super.initState();
  }

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
                        icon: const Icon(Icons.clear)
                    ) : null,
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
              DeviceBox(
                title: 'Thermostat',
                iconPath: 'assets/images/thermometer.png',
                backgroundColor: Theme.of(context).colorScheme.surface,
                borderColor: Theme.of(context).colorScheme.primary,
                titleColor: Theme.of(context).colorScheme.secondary,
                detailColor: Theme.of(context).colorScheme.primary,
                iconColor: Theme.of(context).colorScheme.primary,
              ),
              DeviceBox(
                title: 'Electricity',
                iconPath: 'assets/images/electricity.png',
                backgroundColor: Theme.of(context).colorScheme.surface,
                borderColor: Theme.of(context).colorScheme.primary,
                titleColor: Theme.of(context).colorScheme.secondary,
                detailColor: Theme.of(context).colorScheme.primary,
                iconColor: Theme.of(context).colorScheme.primary,
              ),
              DeviceBox(
                title: 'Gas',
                iconPath: 'assets/images/gas-bottle.png',
                backgroundColor: Theme.of(context).colorScheme.surface,
                borderColor: Theme.of(context).colorScheme.primary,
                titleColor: Theme.of(context).colorScheme.secondary,
                detailColor: Theme.of(context).colorScheme.primary,
                iconColor: Theme.of(context).colorScheme.primary,
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DeviceManagement())
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
      ),
    );
  }
}
