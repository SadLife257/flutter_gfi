import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetail {
  String firstname;
  String lastname;
  String email;
  String imageUrl;

  UserDetail({required this.firstname, required this.lastname, required this.email, required this.imageUrl});

  factory UserDetail.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserDetail(
      firstname: data?['firstname'],
      lastname: data?['lastname'],
      email: data?['email'],
      imageUrl: data?['image_url'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      'image_url': imageUrl,
    };
  }
}