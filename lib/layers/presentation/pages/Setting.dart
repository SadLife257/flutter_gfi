import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/pages/room/RoomCreate.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  static const route_name = '/setting';

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            'Setting',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: 30,
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Add to Home',
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.tertiary,
                    minimumSize: Size.fromHeight(60),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                        context,
                        RoomCreate.route_name,
                    );
                  },
                  label: Text('Add Room'),
                  icon: Icon(Icons.add_home_outlined),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                      minimumSize: Size.fromHeight(60),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      alignment: Alignment.centerLeft
                  ),
                  onPressed: () {},
                  label: Text('Add Family Member'),
                  icon: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Manage',
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.tertiary,
                    minimumSize: Size.fromHeight(60),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {},
                  label: Text('Manage Rooms'),
                  icon: Icon(Icons.home_outlined),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                      minimumSize: Size.fromHeight(60),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      alignment: Alignment.centerLeft
                  ),
                  onPressed: () {},
                  label: Text('Manage Devices'),
                  icon: Icon(Icons.devices_outlined),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                      minimumSize: Size.fromHeight(60),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      alignment: Alignment.centerLeft
                  ),
                  onPressed: () {},
                  label: Text('Manage Family Members'),
                  icon: Icon(Icons.group),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
