import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceManagement.dart';
import 'package:gfi/layers/presentation/pages/room/RoomManagement.dart';
import 'package:gfi/layers/presentation/widgets/custom_icon_button.dart';
import 'package:gfi/layers/presentation/widgets/device_switch.dart';

class Room extends StatefulWidget {
  Color borderColor;
  Color backgroundColor;
  final List<dynamic> devices;
  final String title;

  Room({
    super.key,
    required this.title,
    required this.devices,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.white,}
  );

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {

  void powerSwitchChanged(bool value, int index) {
    setState(() {
      widget.devices[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap:true,
      padding: EdgeInsets.symmetric(
          horizontal: 8
      ),
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: widget.borderColor,
                width: 2.0,
              ),
              color: widget.backgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              widget.title,
                              style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/thermometer.png',
                                height: 35,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              Text(
                                '26°C',
                                style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.tertiary),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          thickness: 0.5,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Manage Room', style: TextStyle(
                                    color: Theme.of(context).colorScheme.tertiary
                                ),),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.tertiary,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => RoomManagement())
                                      );
                                    },
                                    icon: Icon(Icons.home_outlined),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Add Device', style: TextStyle(
                                    color: Theme.of(context).colorScheme.tertiary
                                ),),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.tertiary,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => DeviceManagement())
                                      );
                                    },
                                    icon: Icon(Icons.add),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.devices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) {
            return DeviceSwitch(
              deviceName: widget.devices[index][0],
              iconPath: widget.devices[index][1],
              powerOn: widget.devices[index][2],
              onChanged: (value) => powerSwitchChanged(value, index),
              onTap: () {
                setState(() {
                  widget.devices[index][2] = !widget.devices[index][2];
                });
              },
              backgroundOnColor: Theme.of(context).colorScheme.primary,
              backgroundOffColor: Theme.of(context).colorScheme.tertiary,
              iconOnColor: Theme.of(context).colorScheme.tertiary,
              iconOffColor: Theme.of(context).colorScheme.secondary,
              deviceNameOnColor: Theme.of(context).colorScheme.tertiary,
              deviceNameOffColor: Theme.of(context).colorScheme.secondary,
            );
          },
        )
      ],
    );
  }
}
