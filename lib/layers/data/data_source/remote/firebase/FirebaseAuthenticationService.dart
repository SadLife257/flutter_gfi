import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  get user => _firebaseAuth.currentUser;

  signUp(String email, String password) async {
    _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  resetPassword(String email) async {
    _firebaseAuth.sendPasswordResetEmail(
      email: email
    );
  }

  signInWithEmail(String email, String password) async {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication auth = await user!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken
      );

      return await _firebaseAuth.signInWithCredential(credential).then((_) {
        final userId = _firebaseAuth.currentUser!.uid;
        DocumentReference docRef = FirebaseFirestore.instance.collection('users_info').doc(userId);
        docRef.get().then((doc) {
          if(!doc.exists) {
            FirebaseFirestore.instance.collection('users_info').doc(userId).set({
              "firstname": user.displayName,
              "lastname": '',
              "email": user.email,
              'image_url': 'images/avatar.png',
            }).then((_) {

            });
          }
        });
      });

      // return await _firebaseAuth.signInWithCredential(credential).then((_) {
      //   final userId = _firebaseAuth.currentUser!.uid;
      //   DocumentReference docRef = FirebaseFirestore.instance.collection('users_info').doc(userId);
      //   docRef.get().then((doc) {
      //     if(!doc.exists) {
      //       FirebaseFirestore.instance.collection('users_info').doc(userId).set({
      //         "firstname": user.displayName,
      //         "lastname": '',
      //         "email": user.email,
      //         'image_url': 'images/avatar.png',
      //       });
      //     }
      //   });
      // });
    } catch(e) {
      print('------------${e.toString()}');
    }
  }
}