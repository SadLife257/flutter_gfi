import 'package:flutter/material.dart';

class RoomSetting extends StatefulWidget {
  const RoomSetting({super.key});

  @override
  State<RoomSetting> createState() => _RoomSettingState();
}

class _RoomSettingState extends State<RoomSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Room Management',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: Size.fromHeight(60),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, 'delete');
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: Text(
                  'Delete',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
