import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
        title: const Text('Register'),
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
              final userCredential = await auth.createUserWithEmailAndPassword(
                email: email!,
                password: password!,
              );
              if (userCredential.user != null) {
                passwordConroller.clear();
                emailController.clear();
                Navigator.pushNamed(context, '/chat');
              }
            } catch (e) {
              print(e);
            }
          },
          child: const Text('Register'),
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
