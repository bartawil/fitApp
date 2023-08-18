import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.message.toString() == "The email address is badly formatted.") {
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text(e.message.toString(),
              style: const TextStyle(fontSize: 14),)),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'For getting a reset link benter your Email',
              style: TextStyle(fontSize:16),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 75),

          // email field
          MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),

          const SizedBox(height: 25),
          
          // button
          MyButton(
            text: 'Reset Password',
            onTap: passwordReset,
          ),
        ],
      ),
    );
  }
}