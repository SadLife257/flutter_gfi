import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/pages/AuthReDirect.dart';
import 'package:gfi/layers/data/UserDetail.dart';

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
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
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
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          extendBody: true,
          resizeToAvoidBottomInset: false,
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
                        'Register',
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
                          hintText: 'Enter your first name',
                          labelText: 'First Name',
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
                            return "Please enter your first name";
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
                          hintText: 'Enter your last name',
                          labelText: 'Last Name',
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
                            return "Please enter your last name";
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
                          hintText: 'Enter your email',
                          labelText: 'Email',
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
                            return "Please enter your email";
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
                          hintText: 'Enter your password',
                          labelText: 'Password',
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
                            return "Please enter your password";
                          }
                          if(value != confirmPasswordController.text) {
                            return 'Incorrect password';
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
                          hintText: 'Enter your password, again',
                          labelText: 'Confirm Password',
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
                            return "Please enter your password";
                          }
                          if(value != passwordController.text) {
                            return 'Incorrect password';
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
                          child: Text('REGISTER'),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account!',
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
                          child: const Text(
                            'Login now',
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
      ),
    );
  }
}
