import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color backgroundUnreadColor;
  Color titleColor;
  Color detailColor;
  Color iconColor;
  final String title;
  final String detail;
  final bool isRead;
  void Function()? onTap;

  Message({
    super.key,
    this.titleColor = Colors.white,
    this.detailColor = Colors.white,
    this.iconColor = Colors.white,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.backgroundUnreadColor = Colors.white,
    required this.title,
    required this.detail,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isRead ? backgroundColor : backgroundUnreadColor,
          border: Border.all(color: borderColor, width: isRead ? 1 : 4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Visibility(
                    visible: !isRead,
                    child: Icon(
                      Icons.notifications,
                      size: 40,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: titleColor
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        detail,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 10,
                          color: detailColor
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
