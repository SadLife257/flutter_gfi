import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/pages/authentication/ForgotPassword.dart';
import 'package:gfi/layers/presentation/pages/authentication/Register.dart';
import 'package:gfi/layers/presentation/widgets/square_tile.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginFormKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool _toggleObscurePassword = true;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  void signInEmail() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );
      Navigator.pop(context);
    } on FirebaseException catch(e) {
      Navigator.pop(context);
      showWrongAuthMessage();
    }
  }

  void showWrongAuthMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Text(
              'Email or password is incorrect',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
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
            child: Form(
              key: loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                      ),
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                      textInputAction: TextInputAction.done,
                      obscureText: _toggleObscurePassword,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                      ),
                      decoration: InputDecoration(
                          hintText: 'Password',
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
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _toggleObscurePassword =
                                  !_toggleObscurePassword;
                                });
                              },
                              icon: _toggleObscurePassword ? Icon(Icons.visibility, color: Theme.of(context).colorScheme.primary)
                              : Icon(Icons.visibility_off, color: Theme.of(context).colorScheme.primary)
                          )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ],
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
                          if(loginFormKey.currentState!.validate()) {
                            signInEmail();
                          }
                        },
                        child: Text('LOGIN'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color:  Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color:  Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color:  Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(imagePath: 'assets/images/google.png', backgroundColor: Theme.of(context).colorScheme.primary, borderColor: Theme.of(context).colorScheme.secondary),
                        SizedBox(width: 25),
                        SquareTile(imagePath: 'assets/images/facebook.png', backgroundColor: Theme.of(context).colorScheme.primary, borderColor: Theme.of(context).colorScheme.secondary),
                        SizedBox(width: 25),
                        SquareTile(imagePath: 'assets/images/apple.png', backgroundColor: Theme.of(context).colorScheme.primary, borderColor: Theme.of(context).colorScheme.secondary, imageColor: Theme.of(context).colorScheme.tertiary,)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color:  Theme.of(context).colorScheme.secondary),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: const Text(
                          'Join us',
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
