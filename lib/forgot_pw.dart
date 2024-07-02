import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super (key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }


  Future passwordReset() async {
    try{
      const SizedBox(height:50);
      await FirebaseAuth.instance.
      sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! check your email'),
            );
          }
      );
    }on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        elevation: 0,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
            child: Text(
                'Enter Your Email we will send you a password reset link',
              style: TextStyle(color: Colors.black54,
              fontSize: 20),

            ),
          ),
          SizedBox(height:10),

          //EMAIL TEXTFIELD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.white,
                filled:true,
              ),
                ),
              ),

          SizedBox(height:10),

          MaterialButton(
            onPressed: () => passwordReset(),
            child: Text(
              'Reset Password',
              style: TextStyle(color: Colors.white), // Set the text color to white
            ),
            color: Colors.pinkAccent,
          ),

        ],
            ),
          );
  }
}

