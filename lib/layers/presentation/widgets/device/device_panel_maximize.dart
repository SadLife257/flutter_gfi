import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gfi/layers/presentation/widgets/device/device_chart.dart';
import 'package:gfi/layers/presentation/widgets/device/device_scroll_wheel.dart';
import 'package:gfi/layers/presentation/widgets/device/device_switch.dart';
import 'package:gfi/layers/presentation/widgets/device/device_variable_box.dart';

class DevicePanelMaximize extends StatelessWidget {
  final bool isDeviceOnline;
  final String deviceName;

  final Function() onMaximize;

  final bool isAutoMode;
  final Function(bool) autoModeOnChanged;
  final Function() autoModeOnTap;

  final bool isServo;
  final Function(bool) servoOnChanged;
  final Function() servoOnTap;

  final Function() gasLimitOnTap;
  final int gasDetect;
  final int gasLimit;

  final int relayValue;
  final Function(int) relayOnChanged;

  final List<FlSpot> data;

  double borderWidth;

  DevicePanelMaximize({
    super.key,
    required this.isDeviceOnline,
    required this.deviceName,
    required this.onMaximize,
    required this.isAutoMode,
    required this.autoModeOnChanged,
    required this.autoModeOnTap,
    required this.isServo,
    required this.servoOnChanged,
    required this.servoOnTap,
    required this.gasDetect,
    required this.gasLimit,
    required this.gasLimitOnTap,
    required this.relayValue,
    required this.relayOnChanged,
    required this.data,
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
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 8,
              mainAxisCellCount: 1,
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
                        isDeviceOnline ? AppLocalizations.of(context)!.online : AppLocalizations.of(context)!.offline,
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
                    onPressed: onMaximize,
                    icon: Icon(
                      Icons.keyboard_arrow_up,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ),
                ],
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: DeviceSwitch(
                deviceName: AppLocalizations.of(context)!.auto,
                powerOn: isAutoMode,
                onChanged: autoModeOnChanged,
                onTap: autoModeOnTap,
                backgroundOnColor: Theme.of(context).colorScheme.primary,
                backgroundOffColor: Theme.of(context).colorScheme.tertiary,
                iconOnColor: Theme.of(context).colorScheme.tertiary,
                iconOffColor: Theme.of(context).colorScheme.secondary,
                deviceNameOnColor: Theme.of(context).colorScheme.tertiary,
                deviceNameOffColor: Theme.of(context).colorScheme.secondary,
                borderWidth: 0.1,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: DeviceSwitch(
                deviceName: AppLocalizations.of(context)!.servo,
                powerOn: isServo,
                onChanged: servoOnChanged,
                onTap: servoOnTap,
                backgroundOnColor: Theme.of(context).colorScheme.primary,
                backgroundOffColor: Theme.of(context).colorScheme.tertiary,
                iconOnColor: Theme.of(context).colorScheme.tertiary,
                iconOffColor: Theme.of(context).colorScheme.secondary,
                deviceNameOnColor: Theme.of(context).colorScheme.tertiary,
                deviceNameOffColor: Theme.of(context).colorScheme.secondary,
                borderWidth: 0.1,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 6,
              mainAxisCellCount: 6,
              child: DeviceChart(
                data: data,
                limitRange: gasLimit.toDouble(),
                min_x: data.first.x,
                max_x: data.last.x, //every minute
                min_y: 0,
                max_y: gasLimit.toDouble() + (gasLimit.toDouble() * 30 / 100),
                horizontalInterval: (gasLimit.toDouble() + (gasLimit.toDouble() * 70 / 100)) / 10,
                verticalInterval: (data.last.x - data.first.x + 1) / 5,
                mainGridColor: Theme.of(context).colorScheme.primary,
                gradientColors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary],
                reduceNum: 500,
                borderWidth: 0.1,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 3,
              child: DeviceVariableBox(
                deviceName: AppLocalizations.of(context)!.gas,
                value: gasDetect,
                limit: gasLimit,
                onTap: gasLimitOnTap,
                backgroundColor: Theme.of(context).colorScheme.primary,
                borderWidth: 0.1,
              ),
            ),
            StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 3,
                child: DeviceScrollWheel(
                  name: AppLocalizations.of(context)!.relay,
                  initialItem: relayValue,
                  relay_list: [0, 1, 2, 3],
                  onSelectedItemChanged: relayOnChanged,
                  borderWidth: 0.1,
                )
            ),
          ],
        ),
      )
    );
  }
}
