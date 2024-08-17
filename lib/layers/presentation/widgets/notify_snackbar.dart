import 'package:flutter/material.dart';

class CustomSnack {
  CustomSnack._();
  static showNotifySnack(BuildContext context, String message, IconData messageIcon, Color messageColor, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              messageIcon,
              color: messageColor,
              size: 20,
            ),
            Text(
              message,
              style: TextStyle(
                color: messageColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 1),
      ),
    );
  }
}