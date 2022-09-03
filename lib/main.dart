import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

//screen imports
import './screens/chat_screen.dart';
import './screens/welcome_screen.dart';
import './screens/registration_screen.dart';
import './screens/login-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blueAccent),
          fontFamily: 'Quicksand'),
      // theme: ThemeData(primarySwatch: Colors.blueAccent),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/login': (context) => const LoginScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
