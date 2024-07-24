import 'package:flutter/material.dart';

class DeviceBox extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color titleColor;
  Color detailColor;
  Color iconColor;
  final String title;
  final String iconPath;

  DeviceBox({
    super.key,
    this.titleColor = Colors.white,
    this.detailColor = Colors.white,
    this.iconColor = Colors.white,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.white,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 2),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  iconPath,
                  height: 65,
                  color: iconColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.mode, color: iconColor,)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
