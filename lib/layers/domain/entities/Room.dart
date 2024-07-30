import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gfi/layers/domain/entities/Device.dart';

class Room {
  String name;
  Map<String, Device> devices;
  DateTime? timestamp;

  Room({required this.name, required this.devices, this.timestamp});

  factory Room.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Room(
        name: data?['name'],
        devices: data?['devices'],
        timestamp: data?['timestamp'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "name": name,
      "devices": devices.map((k, v) => MapEntry(k, v.toJson())),
      "timestamp": timestamp,
    };
  }
}