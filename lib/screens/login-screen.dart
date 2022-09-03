import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final Controller emailController;

  final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordConroller = TextEditingController();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(children: [
        TextField(
          controller: emailController,
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: passwordConroller,
        ),
        const SizedBox(
          height: 8,
        ),
        ElevatedButton(
          onPressed: () async {
            email = emailController.text;
            password = passwordConroller.text;

            try {
              final userCredential = await auth.signInWithEmailAndPassword(
                  email: email!, password: password!);
              print(userCredential.user!.email);
              if (userCredential.user != null) {
                passwordConroller.clear();
                emailController.clear();
                Navigator.pushNamed(context, '/chat');
              }
            } catch (e) {
              print(e);
            }
          },
          child: const Text('Login'),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'))
      ]),
    );
  }
}
