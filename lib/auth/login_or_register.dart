import 'package:flutter/material.dart';
import 'package:fyp2/login_page.dart';
import 'package:fyp2/register_page.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: showLoginPage
            ? LoginPage(
          onTap: togglePages,
        )
            : RegisterPage(
          onTap: togglePages,
        ),
      ),
    );
  }
}
