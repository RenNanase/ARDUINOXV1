import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp2/home_page.dart';
import 'auth/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArduinoX',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[50], // Set scaffold background color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink[100], // Set app bar background color
        ),
      ),
      home: MainPage(),
      routes: {
        '/home': (context) => HomePage(),
      },
    );
  }
}
