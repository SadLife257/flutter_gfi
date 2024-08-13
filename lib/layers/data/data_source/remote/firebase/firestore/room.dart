import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gfi/firebase_options.dart';
import 'package:gfi/layers/domain/entities/Device/Hardware.dart';
import 'package:gfi/layers/domain/entities/Room.dart';

class FirestoreRoomCRUD {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  get user => _firebaseAuth.currentUser;

  Future<FirestoreRoomCRUD> initialize() async {
    if(Firebase.apps.length == 0) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    return this;
  }

  Future<List<Room>> getRoom() async {
    List<Room> rooms = [];
    try {
      await _fireStore.collection('users_room').doc(user.uid).get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        data.forEach((k, v) {
          Room room = Room(
            name: v['name'],
            hardware: v['hardware'].map<String, Hardware>((key, data) =>
                MapEntry<String, Hardware>(key, new Hardware(
                  name: data?['name'],
                  image_url: data?['image_url'],
                  token: data?['token'],
                ))
            ),
            timestamp: v['timestamp'].toDate(),
          );
          rooms.add(
              room
          );
        });
      });
    } catch(e) {

    }
    return rooms;
  }
}