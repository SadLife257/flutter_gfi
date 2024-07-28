import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceManagement.dart';
import 'package:gfi/layers/presentation/pages/room/RoomManagement.dart';

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
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      thickness: 2,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Room Temperature', style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary
                            ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/thermometer.png',
                                  height: 50,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                                Text(
                                  '26°C',
                                  style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.tertiary),
                                )
                              ],
                            ),
                          ],
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
                            Text('Manage Room', style: TextStyle(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
