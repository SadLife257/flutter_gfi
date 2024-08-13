import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String title;
  String detail;
  bool isRead;
  DateTime? timestamp;

  Notification({
    required this.title,
    required this.detail,
    required this.isRead,
    this.timestamp
  });

  factory Notification.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Notification(
      title: data?['title'],
      detail: data?['detail'],
      isRead: data?['is_read'],
      timestamp: data?['timestamp'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "title": title,
      "detail": detail,
      "is_read": isRead,
      "timestamp": timestamp,
    };
  }
}