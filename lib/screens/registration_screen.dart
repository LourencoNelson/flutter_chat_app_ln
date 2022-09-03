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
      // appBar: AppBar(
      //   title: const Text('Register'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                // topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                // bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              side: BorderSide(color: Colors.blueAccent, width: 1.5),
            ),
            elevation: 8,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Register',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blueAccent,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Text(
                  //   'AN ICT4DEV SUMMER SCHOOLS PROJECT  ',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 10,
                  //     color: Colors.white,
                  //     letterSpacing: 1.5,
                  //   ),
                  // ),
                  // Text(
                  //   'lourenco manhica',
                  //   style: TextStyle(
                  //     fontSize: 10,
                  //     color: Colors.blueAccent,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    // bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    // bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    // bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              controller: emailController,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter a password',
                labelText: 'Password',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    // bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    // bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    // bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              controller: passwordConroller,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  // bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                side: BorderSide(color: Colors.blueAccent, width: 1.5),
              ),
            ),
            onPressed: () async {
              email = emailController.text;
              password = passwordConroller.text;

              try {
                final userCredential =
                    await auth.createUserWithEmailAndPassword(
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
          const SizedBox(
            height: 10,
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(100, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  // bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                side: BorderSide(color: Colors.blueAccent, width: 1.5),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Back',
              style: TextStyle(color: Colors.blueAccent),
            ),
          )
        ],
      ),
    );
  }
}
