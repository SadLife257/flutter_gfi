import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:gfi/layers/presentation/pages/Home.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerfied = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerfied) {
      sendVerificationEmail();
      
      timer = Timer.periodic(
        Duration(seconds: 5),
        (_) => checkEmailVerified(),
      );
    }
    super.initState();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 2));
    } catch(e) {
      //showExceptionMessage(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerfied) {
      timer?.cancel();
      Future.delayed(const Duration(milliseconds: 50), () {
        setState(() {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
        });
      });
    }
  }

  void showExceptionMessage(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  AppLocalizations.of(context)!.check_email,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  AppLocalizations.of(context)!.check_email_explain,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                      minimumSize: Size.fromHeight(60),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                    ),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                    child: Text(AppLocalizations.of(context)!.resend_cap,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                      minimumSize: Size.fromHeight(60),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Text(AppLocalizations.of(context)!.cancel_cap),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
