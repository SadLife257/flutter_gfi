import 'package:flutter/material.dart';

class ConnectDeviceBox extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color titleColor;
  Color detailColor;
  Color iconColor;
  final String title;
  void Function()? onTap;

  ConnectDeviceBox({
    super.key,
    this.titleColor = Colors.white,
    this.detailColor = Colors.white,
    this.iconColor = Colors.white,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.white,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 2),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.wifi, color: iconColor,)
                  ),
                  Expanded(
                    flex: 4,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
