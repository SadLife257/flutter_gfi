import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gfi/layers/domain/entities/Device/Hardware.dart';

class Room {
  String name;
  Map<String, Hardware> hardware;
  DateTime? timestamp;

  Room({required this.name, required this.hardware, this.timestamp});

  factory Room.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Room(
      name: data?['name'],
      hardware: data?['hardware'],
      timestamp: data?['timestamp'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "name": name,
      "hardware": hardware.map((k, v) => MapEntry(k, v.toJson())),
      "timestamp": timestamp,
    };
  }
}