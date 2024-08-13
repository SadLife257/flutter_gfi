import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:gfi/layers/data/data_source/remote/firebase/FirebaseAuthenticationService.dart';
import 'package:gfi/layers/domain/entities/UserDetail.dart';
import 'package:gfi/layers/presentation/pages/AuthReDirect.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final registerFormKey = GlobalKey<FormState>();
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  void signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );

    try {
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuthentication().signUp(
          emailController.text,
          passwordController.text
        );

        saveUserDetail(UserDetail(
            firstname: firstNameController.text.trim(),
            lastname: lastNameController.text.trim(),
            email: emailController.text.trim(),
            imageUrl: 'images/avatar.png'
          // imageUrl: 'images/avatar.png'
        ));

        Navigator.pop(context);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AuthReDirect(),
          ),
        );
      }
      else {
        registerFormKey.currentState?.activate();
      }
    } on FirebaseException catch(e) {
      showExceptionMessage(e.toString());
      Navigator.pop(context);
    }
  }

  Future saveUserDetail(UserDetail user) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users_info').doc(userId).set(user.toJson());
  }

  void showExceptionMessage(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        appBar: null,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      AppLocalizations.of(context)!.register,
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: TextFormField(
                      controller: firstNameController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.firstname_hint,
                        labelText: AppLocalizations.of(context)!.firstname,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.firstname_error_empty;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: TextFormField(
                      controller: lastNameController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.lastname_hint,
                        labelText: AppLocalizations.of(context)!.lastname,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.lastname_error_empty;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.email,
                        labelText: AppLocalizations.of(context)!.email_hint,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.email_error_empty;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.password_hint,
                        labelText: AppLocalizations.of(context)!.password,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.password_error_empty;
                        }
                        if(value != confirmPasswordController.text) {
                          return AppLocalizations.of(context)!.password_error_confirm_wrong;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.confirm_password_hint,
                        labelText: AppLocalizations.of(context)!.confirm_password,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.confirm_password_error_empty;
                        }
                        if(value != passwordController.text) {
                          return AppLocalizations.of(context)!.password_error_confirm_wrong;
                        }
                        return null;
                      },
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
                            )
                        ),
                        onPressed: () {
                          if(registerFormKey.currentState!.validate()) {
                            signUp();
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.register_cap),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.already_have_account,
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AuthReDirect(),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login_now,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
