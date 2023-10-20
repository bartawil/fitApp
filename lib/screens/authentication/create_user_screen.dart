
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_demo/components/constants.dart';
import 'package:flutter_demo/components/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
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
  List<String> gender = ['male', 'female']; 
  String genderValue = 'male';
  String? _errorMsg;
  
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
					setState(() {
					  signUpRequired = false;
            // Go Back to Welcome Screen (SignUp toggle).
            Navigator.pop(context);
					});
				} else if (state is SignUpProcess) {
					setState(() {
					  signUpRequired = true;
					});
				} else if (state is SignUpFailure) {
					setState(() {
            signUpRequired = false;
            // Create an alert dialog to display the error message.
            if (state.message != null) {
              _errorMsg = state.message!;
            }
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                content: Text(_errorMsg!),
              );
            });
          });
				} 
      },
      child: Form(
        key: _formKey,
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
          body: Center(
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                          child: Image.asset('assets/images/dumbel.png', width: 125, height: 125),
                        ),
                      ),
                      Text(
                        'FITAPP',
                        style: GoogleFonts.playfairDisplay(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 42,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
								// First Name text field
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
								// Last Name text field
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
                const SizedBox(height: 10),
								// Phone number text field
                SizedBox(
									width: MediaQuery.of(context).size.width * 0.9,
									child: MyTextField(
										controller: phoneNumberController,
										hintText: 'Phone Number',
										obscureText: false,
										keyboardType: TextInputType.number,
										prefixIcon: const Icon(CupertinoIcons.phone_fill),
										validator: (val) {
											if (val!.isEmpty) {
												return 'Please fill in this field';													
											} else if (!israeliPhoneNumberRexExp.hasMatch(val)) {
                        return 'Please enter a valid phone number';
                      } else if (val.length < 10 || val.length > 10) {
                        return 'Please enter a valid phone number';
                      }
											return null;
										}
									),
								),
                const SizedBox(height: 10),
								// age text field
                SizedBox(
									width: MediaQuery.of(context).size.width * 0.9,
									child: MyTextField(
										controller: ageController,
										hintText: 'Age',
										obscureText: false,
										keyboardType: TextInputType.number,
										prefixIcon: const Icon(CupertinoIcons.chart_bar_alt_fill),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else {
                        try {
                          double age = double.parse(val);
                          if (age < 16 || age > 120) {
                            return 'Age must be between 16 and 120';
                          }
                        } catch (e) {
                          return 'Please enter a valid number';
                        }
                      }
                      return null;
                    }
									),
								),
                const SizedBox(height: 10),
								// heigh text field
                SizedBox(
									width: MediaQuery.of(context).size.width * 0.9,
									child: MyTextField(
										controller: heightController,
										hintText: 'Height in centimeters',
										obscureText: false,
										keyboardType: TextInputType.number,
										prefixIcon: const Icon(CupertinoIcons.chart_bar_alt_fill),
										validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else {
                        try {
                          double age = double.parse(val);
                          if (age < 120 || age > 250) {
                            return 'Please enter a valid height';
                          }
                        } catch (e) {
                          return 'Please enter a valid number';
                        }
                      }
                      return null;
                    }
									),
								),
                const SizedBox(height: 10),
								// weight text field
                SizedBox(
									width: MediaQuery.of(context).size.width * 0.9,
									child: MyTextField(
										controller: weightController,
										hintText: 'Weight in kilograms',
										obscureText: false,
										keyboardType: TextInputType.number,
										prefixIcon: const Icon(CupertinoIcons.chart_bar_alt_fill),
										validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else {
                        try {
                          double age = double.parse(val);
                          if (age < 30 || age > 250) {
                            return 'Please enter a valid weight';
                          }
                        } catch (e) {
                          return 'Please enter a valid number';
                        }
                      }
                      return null;
                    }
									),
								),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text('male'),
                              leading: Radio(
                                value: gender[0],
                                groupValue: genderValue,
                                onChanged: (value) {
                                  setState(() {
                                    genderValue = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('female'),
                              leading: Radio(
                                value: gender[1],
                                groupValue: genderValue,
                                onChanged: (value) {
                                  setState(() {
                                    genderValue = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Create the user account
                !signUpRequired
									? SizedBox(
											width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
											child: TextButton(
												onPressed: () {
													if (_formKey.currentState!.validate()) {
                            // Create a new MyUser object with the email and user details.
                            MyUser myUser = MyUser.empty;
														myUser = myUser.copyWith(
															email: widget.userEmail,
															firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              phoneNumber: phoneNumberController.text,
                              age: ageController.text,
                              height: heightController.text,
                              weight: weightController.text,
                              gender: genderValue,
														);
                            // Create user by email and password.
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
												child: Padding(
													padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
													child: Text(
														'Sign Up',
														textAlign: TextAlign.center,
														style: TextStyle(
															color: Theme.of(context).colorScheme.onPrimary,
															fontSize: 16,
															fontWeight: FontWeight.w900
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
