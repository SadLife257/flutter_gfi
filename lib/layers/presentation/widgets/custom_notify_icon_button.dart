import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNotifyIconButton extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color iconColor;
  double borderWidth;
  final IconData iconActive;
  final IconData iconInacctive;
  final void Function() onPressed;
  final int unreadMessage;

  CustomNotifyIconButton({
    super.key,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.borderWidth = 0.5,
    required this.iconActive,
    required this.iconInacctive,
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
            width: 0.5,
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
                unreadMessageCount().isEmpty ? iconInacctive : iconActive,
                size: 20.0,
                color: unreadMessageCount().isEmpty ? iconColor : Colors.redAccent,
              ),
              Text(unreadMessageCount())
            ],
          ),
        ),
      ),
    );
  }
}
