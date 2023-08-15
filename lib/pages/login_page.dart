
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/my_button.dart';
import 'package:flutter_demo/components/my_textfield.dart';
import 'package:flutter_demo/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in
  void signUserIn() {

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
          
              // username
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
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