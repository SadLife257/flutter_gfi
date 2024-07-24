import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color iconColor;
  final IconData icon;
  final void Function() onPressed;

  CustomIconButton({
    super.key,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ),
        color: backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: InkWell(
        //This keeps the splash effect within the circle
        borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
        onTap: onPressed,
        child: Padding(
          padding:EdgeInsets.all(10.0),
          child: Icon(
            icon,
            size: 20.0,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
