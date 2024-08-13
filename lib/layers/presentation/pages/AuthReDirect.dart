import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/pages/Home.dart';
import 'package:gfi/layers/presentation/pages/authentication/EmailVerification.dart';
import 'package:gfi/layers/presentation/pages/authentication/Login.dart';

class AuthReDirect extends StatelessWidget {
  const AuthReDirect({super.key});

  static const route_name = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              if(snapshot.data?.emailVerified == true) {
                //snapshot.data.uid
                return Home();
              }
              else{
                return EmailVerification();
              }
            }
            else {
              return Login();
            }
          },
        ),
      ),
    );
  }
}
