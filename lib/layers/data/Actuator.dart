import 'package:cloud_firestore/cloud_firestore.dart';

class Actuator {
  //(0: Manual, 1: Auto)
  bool mode;
  bool isOn;

  Actuator({
    required this.mode,
    required this.isOn,
  });

  factory Actuator.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Actuator(
      mode: data?['mode'],
      isOn: data?['is_on'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "mode": mode,
      'is_on': isOn,
    };
  }
}