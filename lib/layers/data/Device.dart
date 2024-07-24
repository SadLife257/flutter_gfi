import 'package:cloud_firestore/cloud_firestore.dart';

class Device {
  String name;
  String connectionCode;
  bool isOn;
  DateTime timestamp;

  Device({required this.name, required this.connectionCode, required this.isOn, required this.timestamp});

  factory Device.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Device(
      name: data?['name'],
      connectionCode: data?['connection_code'],
      isOn: data?['is_on'],
      timestamp: data?['timestamp']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "name": name,
      "connection_code": connectionCode,
      "is_on": isOn,
      "timestamp": timestamp
    };
  }
}