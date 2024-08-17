import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gfi/layers/domain/entities/Device/Hardware.dart';
import 'package:gfi/layers/domain/entities/Room/Room.dart';

class DeviceCRUDService {
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  get user => _firebaseAuth.currentUser;

  updateMaximizeState(Room room, String key, Hardware hardware, bool isMaximize) async {
    _fireStore.collection('users_room').doc(FirebaseAuth.instance.currentUser!.uid).update({
      '${room.name}.hardware.$key.is_maximize': isMaximize
    });
  }
}