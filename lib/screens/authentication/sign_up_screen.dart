import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_demo/screens/authentication/create_user_screen.dart';

import '../../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../components/strings.dart';
import '../../components/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
	final _formKey = GlobalKey<FormState>();

	final emailController = TextEditingController();
	final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  IconData iconPassword = CupertinoIcons.eye_fill;

  bool obscurePassword = true; 

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(CupertinoIcons.mail_solid),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';													
                  } else if (!emailRexExp.hasMatch(val)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                }
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(CupertinoIcons.lock_fill),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';			
                  } else if (!passwordRexExp.hasMatch(val)) {
                    return 'Please enter a valid password';
                  }
                  return null;
                }
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(CupertinoIcons.lock_fill),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                      if (obscurePassword) {
                        iconPassword = CupertinoIcons.eye_fill;
                      } else {
                        iconPassword = CupertinoIcons.eye_slash_fill;
                      }
                    });
                  },
                  icon: Icon(iconPassword),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';			
                  } else if (!passwordRexExp.hasMatch(val)) {
                    return 'Please enter a valid password';
                  }
                  if (passwordController.text != confirmPasswordController.text) {
                    return 'Passwords must match!';
                  }
                  return null;
                }
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context, 
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider<SignUpBloc>(
                            create: (context) => SignUpBloc(
                              userRepository: context.read<AuthenticationBloc>().userRepository,
                            ),
                            child: CreateUserScreen(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }));																		
                  }
                },
                style: TextButton.styleFrom(
                  elevation: 3.0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}