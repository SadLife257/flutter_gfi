import 'package:cloud_firestore/cloud_firestore.dart';

class Hardware {
  static const String MQ2 = 'v0';
  static const String RELAY = 'v1';
  static const String SERVO = 'v2';
  static const String MQ2_THRESHOLD = 'v3';
  static const String AUTO_MODE = 'v4';

  String name;
  String image_url;
  String token;
  bool isMaximize;
  // int gasLimit;
  // int gasDetect;
  // bool isAuto;
  // bool isOn;
  // int relay;
  // Token token;

  Hardware({
    required this.name,
    required this.image_url,
    required this.token,
    required this.isMaximize,
  });

  factory Hardware.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Hardware(
      name: data?['name'],
      image_url: data?['image_url'],
      token: data?['token'],
      isMaximize: data?['is_maximize'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "name": name,
      "image_url": image_url,
      "token": token,
      "is_maximize": isMaximize,
    };
  }
}