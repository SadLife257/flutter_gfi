import 'package:flutter/material.dart';

class DeviceVariableBox extends StatelessWidget {
  final String deviceName;
  final int value;
  final int limit;
  Color backgroundColor;
  double borderWidth;

  DeviceVariableBox({
    super.key,
    required this.deviceName,
    required this.value,
    required this.limit,
    this.backgroundColor = Colors.black,
    this.borderWidth = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
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
