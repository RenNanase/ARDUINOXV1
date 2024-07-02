import 'package:flutter/material.dart';
import 'package:fyp2/auth/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Trigger the navigation to MainPage after 7 seconds
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage())
      );

    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/logo.png', // image path
              width: 350, // width
              height: 350, // height
            ),
            const SizedBox(height: 30), // spacing
            const Text(
              'ArduinoX',
              style: TextStyle(
                fontSize: 100,
                fontFamily: 'Wkwk-2O988',
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}