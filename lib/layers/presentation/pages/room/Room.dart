import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfi/layers/data/Device.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceManagement.dart';
import 'package:gfi/layers/presentation/pages/room/RoomManagement.dart';
import 'package:gfi/layers/presentation/widgets/custom_icon_button.dart';
import 'package:gfi/layers/presentation/widgets/device_switch.dart';
import 'package:gfi/layers/presentation/widgets/room_header_box.dart';
import 'package:gfi/layers/data/Room.dart' as RoomData;

class Room extends StatefulWidget {
  Color borderColor;
  Color backgroundColor;
  final RoomData.Room room;

  Room({
    super.key,
    required this.room,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.white,}
  );

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  late List<Device> devices;

  @override
  void initState() {
    getDevices();
    super.initState();
  }

  void powerSwitchChanged(bool value, int index) async{
    setState(() {
      devices[index].actuator.isOn = value;
    });

    final userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
      '${widget.room.name}.devices.${devices[index].connectionCode}.actuator.is_on': value,
    });
  }

  void getDevices() {
    devices = widget.room.devices.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap:true,
      padding: EdgeInsets.symmetric(
          horizontal: 8
      ),
      children: [
        RoomHeaderBox(
          title: widget.room.name,
          onRoomManage: () {
            Navigator.pushNamed(
              context,
              RoomManagement.route_name,
              arguments: widget.room
            );
          },
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: devices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) {
            return DeviceSwitch(
              deviceName: devices[index].name,
              iconPath: devices[index].image_url,
              powerOn: devices[index].actuator.isOn,
              onChanged: (value) => powerSwitchChanged(value, index),
              onTap: () async {
                setState(() {
                  devices[index].actuator.isOn = !devices[index].actuator.isOn;
                });
                final userId = FirebaseAuth.instance.currentUser!.uid;

                await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
                  '${widget.room.name}.devices.${devices[index].connectionCode}.actuator.is_on': devices[index].actuator.isOn,
                });
              },
              backgroundOnColor: Theme.of(context).colorScheme.primary,
              backgroundOffColor: Theme.of(context).colorScheme.tertiary,
              iconOnColor: Theme.of(context).colorScheme.tertiary,
              iconOffColor: Theme.of(context).colorScheme.secondary,
              deviceNameOnColor: Theme.of(context).colorScheme.tertiary,
              deviceNameOffColor: Theme.of(context).colorScheme.secondary,
            );
          },
        )
      ],
    );
  }
}
