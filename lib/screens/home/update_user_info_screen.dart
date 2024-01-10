import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:flutter_demo/components/constants.dart';
import 'package:flutter_demo/components/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

// This widget is responsible for updating user information.
class UpdateUserInfoScreen extends StatefulWidget {
  final MyUser user;

  const UpdateUserInfoScreen(this.user, {super.key});

  @override
  State<UpdateUserInfoScreen> createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  bool updateWeight = false;
  bool updateRequired = false;
  List<String> gender = ['male', 'female'];
  String genderValue = 'male';

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with user data when the widget is created.
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    phoneNumberController.text = widget.user.phoneNumber;
    ageController.text = widget.user.age;
    heightController.text = widget.user.height;
    weightController.text = widget.user.weight;
    genderValue = widget.user.gender;
  }

  @override
  void dispose() {
    // Dispose of text controllers when the widget is disposed.
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UpdateUserInfoSuccess) {
          // Handle a successful user update info.
          setState(() {
            updateRequired = false;
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (state is UpdateUserInfoLoading) {
          // Handle user update info in progress.
          setState(() {
            updateRequired = true;
          });
        } else if (state is UpdateUserInfoFailure) {
          // Handle user update info failure.
          setState(() {
            updateRequired = false;
            // Create an alert dialog to display the error message.
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Text("Error has occurred!"),
                  );
                });
          });
        }
      },
      child: Form(
        key: _formKey,
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.background,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Theme.of(context).colorScheme.background,
              body: Center(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: BlocBuilder<MyUserBloc, MyUserState>(
                    builder: (context, state) {
                      if (state.user != null) {
                        return Column(children: [
                          const SizedBox(height: 50.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Baseline(
                                baselineType: TextBaseline.alphabetic,
                                baseline: 0.0,
                                child: Text(
                                  'FITAPP',
                                  style: GoogleFonts.playfairDisplay(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 45,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Baseline(
                                baselineType: TextBaseline.alphabetic,
                                baseline: 0.0,
                                child: Text(
                                  'Update Info',
                                  style: GoogleFonts.playfairDisplay(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50.0),
                          // First Name text field
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                                controller: firstNameController,
                                hintText: 'First Name',
                                obscureText: false,
                                keyboardType: TextInputType.name,
                                prefixIcon: const Icon(Icons.person),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else if (val.length > 30) {
                                    return 'Name too long';
                                  }
                                  return null;
                                }),
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
                                prefixIcon: const Icon(Icons.person_2_outlined),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else if (val.length > 30) {
                                    return 'Name too long';
                                  }
                                  return null;
                                }),
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
                                prefixIcon: Transform.rotate(
                                  angle: pi / 12.0,
                                  child: const Icon(
                                    Icons.phone_iphone,
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else if (!israeliPhoneNumberRexExp
                                      .hasMatch(val)) {
                                    return 'Please enter a valid phone number';
                                  } else if (val.length < 10 ||
                                      val.length > 10) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                }),
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
                                prefixIcon: const Icon(Icons.cake_outlined),
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
                                }),
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
                                prefixIcon: Transform.rotate(
                                  angle: -pi / 4.0,
                                  child: const Icon(
                                    Icons.straighten_outlined,
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double height = double.parse(val);
                                      if (height < 120 || height > 250) {
                                        return 'Please enter a valid height';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid number';
                                    }
                                  }
                                  return null;
                                }),
                          ),
                          const SizedBox(height: 10),
                          // weight text field
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                                controller: weightController,
                                hintText: 'Weight in kilograms',
                                obscureText: false,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                prefixIcon: const Icon(Icons.scale_outlined),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else if (val.length < 2) {
                                    return 'Please enter a valid weight';
                                  } else if (!doubleRexExp.hasMatch(val)) {
                                    return 'Format must be XX.XX';
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
                                }),
                          ),
                          const SizedBox(height: 15),
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
                              )),
                          const SizedBox(height: 15),
                          !updateRequired
                              ? TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Create a new MyUser object with the updated data.
                                      MyUser myUser = widget.user;
                                      myUser = myUser.copyWith(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        phoneNumber: phoneNumberController.text,
                                        age: ageController.text,
                                        height: heightController.text,
                                        weight: weightController.text,
                                        gender: genderValue,
                                      );
                                      // update a flag if the user has updated the weight
                                      // in order to update the weight collection in firestore
                                      if (widget.user.weight != myUser.weight) {
                                        updateWeight = true;
                                      }
                                      // call Bloc to update the user info
                                      setState(() {
                                        context
                                            .read<UpdateUserInfoBloc>()
                                            .add(UpdateUserInfo(myUser, updateWeight));
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      elevation: 3.0,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 5),
                                    child: Text(
                                      'Update User Info',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.caveat(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ))
                              : const CircularProgressIndicator()
                        ]);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
