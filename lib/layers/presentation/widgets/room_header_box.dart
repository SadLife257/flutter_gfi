import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class RoomHeaderBox extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color iconColor;
  final String title;
  final Function() onRoomManage;

  RoomHeaderBox({
    super.key,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    required this.title,
    required this.onRoomManage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: VerticalDivider(
                thickness: 2,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.room_management, style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary
                  ),),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: onRoomManage,
                      icon: Icon(Icons.home_outlined),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
