import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceSwitch extends StatelessWidget {
  final String deviceName;
  final String iconPath;
  final bool powerOn;
  void Function(bool)? onChanged;
  void Function()? onTap;
  Color backgroundOnColor;
  Color backgroundOffColor;
  Color deviceNameOnColor;
  Color deviceNameOffColor;
  Color iconOnColor;
  Color iconOffColor;

  DeviceSwitch({
    super.key,
    required this.deviceName,
    required this.iconPath,
    required this.powerOn,
    required this.onChanged,
    required this.onTap,
    this.backgroundOnColor = Colors.grey,
    this.backgroundOffColor = const Color.fromARGB(44, 164, 167, 189),
    this.iconOnColor = Colors.white,
    this.iconOffColor = Colors.grey,
    this.deviceNameOnColor = Colors.white,
    this.deviceNameOffColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: backgroundOnColor, width: 1),
          color: powerOn ? backgroundOnColor : backgroundOffColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                iconPath,
                height: 65,
                color: powerOn ? iconOnColor : iconOffColor,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    deviceName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: powerOn ? deviceNameOnColor : deviceNameOffColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              CupertinoSwitch(
                value: powerOn,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
