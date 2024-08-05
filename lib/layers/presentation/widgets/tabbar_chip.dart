import 'package:flutter/material.dart';

class TabBarChip extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color iconColor;
  double borderWidth;
  final IconData icon;
  final String title;

  TabBarChip({
    super.key,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.borderWidth = 0.5,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 50,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          width: 120,
          decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
                width: 0.5,
              ),
              color: backgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Padding(
            padding:EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  icon,
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
