import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/widgets/device/device_panel_maximize.dart';
import 'package:gfi/layers/presentation/widgets/device/device_panel_minimize.dart';

class DeviceController extends StatelessWidget {

  final bool isDeviceOnline;
  final String deviceName;

  final bool isMaximize;
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

  DeviceController({
    super.key,
    required this.isDeviceOnline,
    required this.deviceName,
    required this.isMaximize,
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
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: isMaximize ?
      DevicePanelMaximize(
        isDeviceOnline: isDeviceOnline,
        deviceName: deviceName,
        onMaximize: onMaximize,
        isAutoMode: isAutoMode,
        autoModeOnChanged: autoModeOnChanged,
        autoModeOnTap: autoModeOnTap,
        isServo: isServo,
        servoOnTap: servoOnTap,
        servoOnChanged: servoOnChanged,
        gasDetect: gasDetect,
        gasLimit: gasLimit,
        gasLimitOnTap: gasLimitOnTap,
        relayValue: relayValue,
        relayOnChanged: relayOnChanged,
        data: data,
      )
      :
      DevicePanelMinimize(
        isDeviceOnline: isDeviceOnline,
        deviceName: deviceName,
        onMaximize: onMaximize,
        isAutoMode: isAutoMode,
        autoModeOnChanged: autoModeOnChanged,
        autoModeOnTap: autoModeOnTap,
        isServo: isServo,
        servoOnTap: servoOnTap,
        servoOnChanged: servoOnChanged,
        gasDetect: gasDetect,
        gasLimit: gasLimit,
        gasLimitOnTap: gasLimitOnTap,
        relayValue: relayValue,
        relayOnChanged: relayOnChanged,
      ),
    );
  }
}
