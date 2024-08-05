import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gfi/layers/data/data_source/remote/BlynkHTTPService.dart';
import 'package:gfi/layers/domain/entities/Device.dart';
import 'package:gfi/layers/domain/entities/Device/Hardware.dart';
import 'package:gfi/layers/presentation/pages/room/RoomManagement.dart';
import 'package:gfi/layers/presentation/widgets/device/device_chart.dart';
import 'package:gfi/layers/presentation/widgets/device/device_controller.dart';
import 'package:gfi/layers/presentation/widgets/device/device_scroll_wheel.dart';
import 'package:gfi/layers/presentation/widgets/device/device_switch.dart';
import 'package:gfi/layers/presentation/widgets/device/device_variable_box.dart';
import 'package:gfi/layers/presentation/widgets/room_header_box.dart';
import 'package:gfi/layers/domain/entities/Room.dart' as RoomData;

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
  late List<Hardware> hardware;
  int initialItem = 0;
  bool autoSwitch = false;
  bool servoSwitch = false;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    hardware = widget.room.hardware.values.toList();
    return ListView(
      shrinkWrap:true,
      padding: EdgeInsets.symmetric(
          horizontal: 4
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          borderColor: Theme.of(context).colorScheme.primary,
          iconColor: Theme.of(context).colorScheme.tertiary,
        ),
        ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 16
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: hardware.length,
          itemBuilder: (BuildContext context, int i) {
            var blynkService = BlynkHTTPService(token: hardware[i].token);
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8
              ),
              child: FutureBuilder(
                future: blynkService.fetchData(),
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if(snapshot.hasData) {
                    return DeviceController(
                      deviceName: hardware[i].name,
                      isAutoMode: snapshot.data?['auto'],
                      autoModeOnChanged: (value) async {
                        blynkService.updateAutoMode(value);
                        setState(() {});
                      },
                      autoModeOnTap: () {
                        blynkService.updateAutoMode(!snapshot.data?['auto']);
                        setState(() {});
                      },
                      isServo: snapshot.data?['servo'],
                      servoOnChanged: (value) {
                        blynkService.updateServo(value);
                        setState(() {});
                      },
                      servoOnTap: () {
                        blynkService.updateAutoMode(!snapshot.data?['servo']);
                        setState(() {});
                      },
                      gasDetect: snapshot.data?['mq2'],
                      gasLimit: snapshot.data?['mq2_threshold'],
                      relayValue: snapshot.data?['relay'],
                      relayOnChanged: (value) {
                        blynkService.updateRelay(value);
                        setState(() {});
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
