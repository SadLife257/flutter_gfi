import 'package:flutter/material.dart';

class CustomNotifyIconButton extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color iconColor;
  final IconData icon;
  final void Function() onPressed;
  final int unreadMessage;

  CustomNotifyIconButton({
    super.key,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    required this.icon,
    required this.onPressed,
    required this.unreadMessage,
  });

  @override
  Widget build(BuildContext context) {
    String unreadMessageCount() {
      if(this.unreadMessage > 100) {
        return '99+';
      }
      else if(this.unreadMessage == 0) {
        return '';
      }
      return this.unreadMessage.toString();
    }

    return Ink(
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(1000.0),
        onTap: onPressed,
        child: Padding(
          padding:EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20.0,
                color: iconColor,
              ),
              Text(unreadMessageCount())
            ],
          ),
        ),
      ),
    );
  }
}
