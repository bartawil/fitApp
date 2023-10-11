import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_demo/components/textfield.dart';
import 'package:flutter_demo/screens/home/home_screen.dart';
import 'package:user_repository/user_repository.dart';

class CreateUserScreen extends StatefulWidget {
  final String userEmail;
  final String userPassword;

  const CreateUserScreen({super.key, required String email, required String password}) : userEmail = email, userPassword = password;

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  
  bool signUpRequired = false;
  
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
					setState(() {
					  signUpRequired = false;
            Navigator.pop(context);
					});
				} else if (state is SignUpProcess) {
					setState(() {
					  signUpRequired = true;
					});
				} else if (state is SignUpFailure) {
					return;
				} 
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
								SizedBox(
									width: MediaQuery.of(context).size.width * 0.9,
									child: MyTextField(
										controller: firstNameController,
										hintText: 'First Name',
										obscureText: false,
										keyboardType: TextInputType.name,
										prefixIcon: const Icon(CupertinoIcons.person_fill),
										validator: (val) {
											if (val!.isEmpty) {
												return 'Please fill in this field';													
											} else if (val.length > 30) {
												return 'Name too long';
											}
											return null;
										}
									),
								),
                const SizedBox(height: 10),
								SizedBox(
									width: MediaQuery.of(context).size.width * 0.9,
									child: MyTextField(
										controller: lastNameController,
										hintText: 'Last Name',
										obscureText: false,
										keyboardType: TextInputType.name,
										prefixIcon: const Icon(CupertinoIcons.person_fill),
										validator: (val) {
											if (val!.isEmpty) {
												return 'Please fill in this field';													
											} else if (val.length > 30) {
												return 'Name too long';
											}
											return null;
										}
									),
								),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                !signUpRequired
									? SizedBox(
											width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
											child: TextButton(
												onPressed: () {
													if (_formKey.currentState!.validate()) {
                            MyUser myUser = MyUser.empty;
														myUser = myUser.copyWith(
															email: widget.userEmail,
															firstName: firstNameController.text,
                              lastName: lastNameController.text,
														);
														setState(() {           
															context.read<SignUpBloc>().add(
																SignUpRequired(
																	myUser,
																	widget.userPassword,
																)
															);
														});														
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
									: const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}