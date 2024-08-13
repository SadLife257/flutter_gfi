import 'package:flutter/material.dart';

class DeviceVariableBox extends StatelessWidget {
  final String deviceName;
  final int value;
  final int limit;
  final Function() onTap;
  Color backgroundColor;
  double borderWidth;
  double borderRadius;

  DeviceVariableBox({
    super.key,
    required this.deviceName,
    required this.value,
    required this.limit,
    required this.onTap,
    this.backgroundColor = Colors.black,
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
          border: Border.all(color: backgroundColor, width: borderWidth),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                deviceName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              Text(
                '$value',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              Divider(
                height: 10,
                thickness: 1,
              ),
              Text(
                '$limit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
