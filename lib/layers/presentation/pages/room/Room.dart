import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gfi/layers/data/data_source/remote/BlynkHTTPService.dart';
import 'package:gfi/layers/domain/entities/Device/Hardware.dart';
import 'package:gfi/layers/domain/entities/Room.dart' as RoomData;
import 'package:gfi/layers/presentation/pages/room/RoomManagement.dart';
import 'package:gfi/layers/presentation/widgets/device/device_controller.dart';
import 'package:gfi/layers/presentation/widgets/device/device_slider.dart';
import 'package:gfi/layers/presentation/widgets/room_header_box.dart';

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
  late List<Hardware> hardware;
  List<FlSpot> data = [];

  @override
  void initState() {
    super.initState();
  }

  Stream<Map<String, dynamic>> fetchData(BlynkHTTPService blynkService) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 100));
      Map<String, dynamic> result = await blynkService.fetchData();
      yield result;
    }
  }

  // List<FlSpot> moveChartForward(double newX, double newY) {
  //
  // }

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
              child: StreamBuilder(
                stream: fetchData(blynkService),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    int gasLimit = 0;
                    double time = DateTime.now().millisecondsSinceEpoch.toDouble();
                    double gasDetected = snapshot.data?['mq2'].toDouble();
                    if(data.length <= 1 || (time != data.last.x && gasDetected != data.last.y)) {
                      data.add(FlSpot(
                        time,
                        gasDetected
                      ));
                    }
                    return DeviceController(
                      isDeviceOnline: snapshot.data?['device_status'],
                      deviceName: hardware[i].name,
                      isAutoMode: snapshot.data?['auto'],
                      autoModeOnChanged: (value) async {
                        blynkService.updateAutoMode(value);
                      },
                      autoModeOnTap: () {
                        blynkService.updateAutoMode(!snapshot.data?['auto']);
                      },
                      isServo: snapshot.data?['servo'],
                      servoOnChanged: (value) {
                        blynkService.updateServo(value);
                      },
                      servoOnTap: () {
                        blynkService.updateServo(!snapshot.data?['servo']);
                      },
                      gasDetect: gasDetected.round(),
                      gasLimit: snapshot.data?['mq2_threshold'],
                      gasLimitOnTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return DeviceSlider(
                                value: snapshot.data?['mq2_threshold'].toDouble(),
                              );
                            }
                        ).then((value) {
                          if(value != null) {
                            blynkService.updateMQ2Threshold(value);
                          }
                        });
                      },
                      relayValue: snapshot.data?['relay'],
                      relayOnChanged: (value) {
                        blynkService.updateRelay(value);
                      },
                      data: data
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                  );
                }
              ),
            );
          },
        )
      ],
    );
  }
}
