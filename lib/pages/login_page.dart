
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/my_button.dart';
import 'package:flutter_demo/components/my_textfield.dart';
import 'package:flutter_demo/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign in
  void signUserIn() async {
    //loading
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
      );
      // pop loading
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }

  }

  void wrongEmailMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Center(child: Text('Incorrect Email')),
        );
      },
    );
  }

    void wrongPasswordMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Center(child: Text('Incorrect password')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back
              Text(
                "Welcome back!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),
          
              // email
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 25),

              // password
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
          
              const SizedBox(height: 10),

              // forgot
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password ?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
          
              // button
              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 50),
          
              // continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                      ),
                    ),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        ' Or continue with ',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
              
                    Expanded(
                      child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                      ),
                    )
                  ],
                ),
              ),
          
              const SizedBox(height: 40),

              // google  and apple
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google
                  SquareTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // apple
                  SquareTile(imagePath: 'lib/images/apple.png'),
                ],
              ),


              const SizedBox(height: 40),
          
              // register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                    ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue, 
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}