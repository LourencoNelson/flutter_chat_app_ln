import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Welcome'),
      // ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      ' Flutter Chat App',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 30,
                        color: Colors.blueAccent,
                        letterSpacing: 2.5,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'AN ICT4DEV SUMMER SCHOOLS PROJECT  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blueAccent,
                        letterSpacing: 1.5,
                      ),
                    ),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
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
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
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
                Navigator.pushNamed(context, '/registration');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
