import 'package:cloud_firestore/cloud_firestore.dart';

class Sensor {
  double value;
  double threshold;

  Sensor({
    required this.value,
    required this.threshold
  });

  factory Sensor.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Sensor(
      value: data?['value'],
      threshold: data?['threshold']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'value': value,
      'threshold': threshold,
    };
  }
}