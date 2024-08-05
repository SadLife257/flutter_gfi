import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gfi/layers/presentation/widgets/device/device_chart.dart';
import 'package:gfi/layers/presentation/widgets/device/device_scroll_wheel.dart';
import 'package:gfi/layers/presentation/widgets/device/device_switch.dart';
import 'package:gfi/layers/presentation/widgets/device/device_variable_box.dart';

class DeviceController extends StatelessWidget {

  final bool isDeviceOnline;
  final String deviceName;
  final Function() deviceEdit;

  final bool isAutoMode;
  final Function(bool) autoModeOnChanged;
  final Function() autoModeOnTap;

  final bool isServo;
  final Function(bool) servoOnChanged;
  final Function() servoOnTap;

  final int gasDetect;
  final int gasLimit;

  final int relayValue;
  final Function(int) relayOnChanged;

  double borderWidth;

  DeviceController({
    super.key,
    required this.isDeviceOnline,
    required this.deviceName,
    required this.deviceEdit,
    required this.isAutoMode,
    required this.autoModeOnChanged,
    required this.autoModeOnTap,
    required this.isServo,
    required this.servoOnChanged,
    required this.servoOnTap,
    required this.gasDetect,
    required this.gasLimit,
    required this.relayValue,
    required this.relayOnChanged,
    this.borderWidth = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: StaggeredGrid.count(
            crossAxisCount: 8,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 8,
                mainAxisCellCount: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Theme.of(context).colorScheme.primary, width: borderWidth),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            color: isDeviceOnline ? Colors.green : Colors.red,
                            size: 10,
                          ),
                          Text(
                            isDeviceOnline ? 'Online' : 'Offline',
                            style: TextStyle(
                              fontSize: 8,
                              color: isDeviceOnline ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary
                            ),
                          ),
                        ],
                      ),
                      Text(
                          deviceName
                      ),
                      IconButton(
                        onPressed: deviceEdit,
                        icon: Icon(Icons.edit),
                      )
                    ],
                  ),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 4,
                mainAxisCellCount: 2,
                child: DeviceSwitch(
                  deviceName: 'Auto',
                  powerOn: isAutoMode,
                  onChanged: autoModeOnChanged,
                  onTap: autoModeOnTap,
                  backgroundOnColor: Theme.of(context).colorScheme.primary,
                  backgroundOffColor: Theme.of(context).colorScheme.tertiary,
                  iconOnColor: Theme.of(context).colorScheme.tertiary,
                  iconOffColor: Theme.of(context).colorScheme.secondary,
                  deviceNameOnColor: Theme.of(context).colorScheme.tertiary,
                  deviceNameOffColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 4,
                mainAxisCellCount: 2,
                child: DeviceSwitch(
                  deviceName: 'Servo',
                  powerOn: isServo,
                  onChanged: servoOnChanged,
                  onTap: servoOnTap,
                  backgroundOnColor: Theme.of(context).colorScheme.primary,
                  backgroundOffColor: Theme.of(context).colorScheme.tertiary,
                  iconOnColor: Theme.of(context).colorScheme.tertiary,
                  iconOffColor: Theme.of(context).colorScheme.secondary,
                  deviceNameOnColor: Theme.of(context).colorScheme.tertiary,
                  deviceNameOffColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 6,
                mainAxisCellCount: 6,
                child: DeviceChart(
                  data: [
                    FlSpot(0, 200),
                    FlSpot(2.6 * 60, 220),
                    FlSpot(4.9 * 60, 100),
                    FlSpot(6.8 * 60, 400),
                    FlSpot(8 * 60, 700),
                    FlSpot(9.5 * 60, 300),
                    FlSpot(11 * 60, 400),
                    FlSpot(13 * 60, 200),
                    FlSpot(14 * 60, 600),
                    FlSpot(16 * 60, 700),
                    FlSpot(17 * 60, 200),
                    FlSpot(19 * 60, 800),
                    FlSpot(20 * 60, 200),
                    FlSpot(21 * 60, 1000),
                    FlSpot(23 * 60, 900),
                    FlSpot(24 * 60, 200),
                  ],
                  limitRange: 1100,
                  min_x: 0,
                  max_x: 24 * 60, //every minute
                  min_y: 0,
                  max_y: 1100 + 400,
                  horizontalInterval: 300,
                  verticalInterval: 3 * 60,
                  mainGridColor: Theme.of(context).colorScheme.primary,
                  gradientColors: [Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.secondary],
                  reduceNum: 500,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 3,
                child: DeviceVariableBox(
                  deviceName: 'Gas',
                  value: gasDetect,
                  limit: gasLimit,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 3,
                  child: DeviceScrollWheel(
                    name: 'Relay',
                    initialItem: relayValue,
                    relay_list: [0, 1, 2, 3],
                    onSelectedItemChanged: relayOnChanged,
                  )
              ),
            ],
          ),
        )
    );
  }
}
