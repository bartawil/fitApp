import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:flutter_demo/components/constants.dart';
import 'package:flutter_demo/components/text_field.dart';
import 'package:google_fonts/google_fonts.dart';

/// This is the `ForgotPasswordScreen` widget, which allows users to reset their password.
/// It displays a form with an email input field and a "Reset Password" button.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  // Controller for the email input field
  final emailController = TextEditingController();

  // Error message for validation
  String? _errorMsg;

  // Flag to track if password reset is required
  bool resetPasswordRequired = false;

  @override
  void dispose() {
    // Dispose of the emailController to prevent memory leaks
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          // Password reset is successful, show a success message
          setState(() {
            resetPasswordRequired = false;
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text("Password reset link sent! Check your email!"),
                );
              },
            );
          });
        } else if (state is ResetPasswordProcess) {
          // Password reset process is in progress, show a loading indicator
          setState(() {
            resetPasswordRequired = true;
          });
        } else if (state is ResetPasswordFailure) {
          // Password reset has failed, show an error message
          setState(() {
            resetPasswordRequired = false;
            if (state.message != null) {
              _errorMsg = state.message!;
            }
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(_errorMsg!),
                );
              },
            );
          });
        }
      },
      child: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.background,
              leading: IconButton(
                icon: const Icon(CupertinoIcons.arrow_left),
                onPressed: () => Navigator.pop(context),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your email address here',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                // Email text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SizedBox(
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
                        } else {
                          return _errorMsg;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Check if the user can reset the password
                !resetPasswordRequired
                    ? SizedBox(
                        child: TextButton(
                          onPressed: () {
                            _errorMsg = null;
                            if (_formKey.currentState!.validate()) {
                              // Trigger the password reset process
                              context.read<ResetPasswordBloc>().add(
                                    ResetPasswordRequired(
                                      emailController.text,
                                    ),
                                  );
                            }
                          },
                          style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 5,
                            ),
                            child: Text(
                              'Reset Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
