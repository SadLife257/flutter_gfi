import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:gfi/layers/data/data_source/remote/firebase/FirebaseAuthenticationService.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final TextEditingController emailController;

  Future resetPassword() async {
    try {
      await FirebaseAuthentication().resetPassword(
        emailController.text.trim()
      );
      showExceptionMessage(AppLocalizations.of(context)!.reset_pass_success,);
    } on FirebaseException catch(e) {
      showExceptionMessage(AppLocalizations.of(context)!.reset_pass_fail,);
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
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.reset_pass,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: 30,
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  AppLocalizations.of(context)!.reset_pass_explain,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.email,
                    labelText: AppLocalizations.of(context)!.email,
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
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
                    onPressed: resetPassword,
                    child: Text(AppLocalizations.of(context)!.send),
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
