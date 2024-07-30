import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gfi/layers/domain/entities/Actuator.dart';
import 'package:gfi/layers/domain/entities/Sensor.dart';

class Device {
  String name;
  String image_url;
  String connectionCode;
  String password;
  Sensor sensor;
  Actuator actuator;
  DateTime timestamp;

  Device({
    required this.name,
    required this.image_url,
    required this.connectionCode,
    required this.password,
    required this.sensor,
    required this.actuator,
    required this.timestamp
  });

  factory Device.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Device(
      name: data?['name'],
      image_url: data?['image_url'],
      connectionCode: data?['connection_code'],
      password: data?['password'],
      sensor: Sensor.fromJson(data?['sensor'], null),
      actuator: Actuator.fromJson(data?['actuator'], null),
      timestamp: data?['timestamp']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "name": name,
      "image_url": image_url,
      "connection_code": connectionCode,
      'password': password,
      "sensor": sensor.toJson(),
      "actuator": actuator.toJson(),
      "timestamp": timestamp
    };
  }
}