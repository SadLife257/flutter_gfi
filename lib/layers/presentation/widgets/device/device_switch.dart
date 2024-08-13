import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class DeviceSwitch extends StatelessWidget {
  final String deviceName;
  final bool powerOn;
  void Function(bool)? onChanged;
  void Function()? onTap;
  Color backgroundOnColor;
  Color backgroundOffColor;
  Color deviceNameOnColor;
  Color deviceNameOffColor;
  Color iconOnColor;
  Color iconOffColor;
  double borderWidth;
  double borderRadius;

  DeviceSwitch({
    super.key,
    required this.deviceName,
    required this.powerOn,
    required this.onChanged,
    required this.onTap,
    this.backgroundOnColor = Colors.grey,
    this.backgroundOffColor = const Color.fromARGB(44, 164, 167, 189),
    this.iconOnColor = Colors.white,
    this.iconOffColor = Colors.grey,
    this.deviceNameOnColor = Colors.white,
    this.deviceNameOffColor = Colors.white,
    this.borderWidth = 0.5,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(color: backgroundOnColor, width: borderWidth),
          color: powerOn ? backgroundOnColor : backgroundOffColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deviceName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: powerOn ? deviceNameOnColor : deviceNameOffColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    powerOn ? AppLocalizations.of(context)!.on : AppLocalizations.of(context)!.off,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: powerOn ? deviceNameOnColor : deviceNameOffColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
              Transform.rotate(
                angle: - pi / 2,
                child: CupertinoSwitch(
                  value: powerOn,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
