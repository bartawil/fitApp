import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:fitapp/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:fitapp/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:fitapp/blocs/weight_bloc/weight_bloc.dart';
import 'package:fitapp/components/constants.dart';
import 'package:fitapp/components/text_field.dart';
import 'package:fitapp/screens/weight/weight_list.dart';
import 'package:fitapp/screens/weight/weight_graph_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

// Define a StatefulWidget for the UpdateWeightScreen.
class UpdateWeightScreen extends StatefulWidget {
  const UpdateWeightScreen({super.key});

  @override
  State<UpdateWeightScreen> createState() => _UpdateWeightScreenState();
}

// State class for UpdateWeightScreen.
class _UpdateWeightScreenState extends State<UpdateWeightScreen> {
  // Define a GlobalKey for the Form.
  final _formKey = GlobalKey<FormState>();
  // Controller for the weight input field.
  final weightController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    // Dispose of FormState if needed
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UpdateUserWeightSuccess) {
          // make the list render after adding a new weight
          context.read<WeightBloc>().add(GetWeightList(
              context.read<AuthenticationBloc>().state.user!.uid));

          // call algorithm to predict next weight
          setState(() {
            context
                .read<UpdateUserInfoBloc>() 
                .add(PredictWeight(userId: context.read<AuthenticationBloc>().state.user!.uid));
          });
        } else if (state is UpdateUserWeightLoading) {
          // Display a loading indicator if weight update is in progress.
          const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PredictWeightSuccess) {
          // Display a snackbar when the weight is updated successfully.
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text('Great job! You are on track!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 27,
                        fontWeight: FontWeight.w900)),
                content: Text(
                    "By keeping track of your progress, your next weight will be ${state.prediction}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 20,
                    )),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    icon: Icon(
                      Icons.thumb_up_alt,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              );
            },
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await Future.delayed(const Duration(milliseconds: 150));
                // Navigate back when the back arrow button is pressed.
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          body: BlocBuilder<MyUserBloc, MyUserState>(builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: MyTextField(
                            controller: weightController,
                            hintText: 'Enter your text here',
                            obscureText: false,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
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
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            MyUser? user = state.user;
                            log(state.user!.weight);
                            log(weightController.text);
                            double bmi = double.parse(weightController.text) /
                                ((double.parse(user!.height) / 100) *
                                    (double.parse(user.height) / 100));
                            user = user.copyWith(
                              weight: weightController.text,
                              bmi: bmi,
                            );
                            setState(() {
                              // Trigger the UpdateUserWeight event when updating weight.
                              context
                                  .read<UpdateUserInfoBloc>()
                                  .add(UpdateUserWeight(
                                    user!,
                                  ));
                            });
                            weightController.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                        style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: Text(
                            'Update Weight',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                        )),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'Weights history',
                            style: GoogleFonts.playfairDisplay(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return MultiBlocProvider(providers: [
                                  BlocProvider(
                                      create: (context) => WeightBloc(
                                          userRepository: context
                                              .read<AuthenticationBloc>()
                                              .userRepository)
                                        ..add(GetWeightList(context
                                            .read<AuthenticationBloc>()
                                            .state
                                            .user!
                                            .uid))),
                                  BlocProvider<MyUserBloc>(
                                    create: (context) => MyUserBloc(
                                        myUserRepository: context
                                            .read<AuthenticationBloc>()
                                            .userRepository)
                                      ..add(GetMyUser(
                                          myUserId: context
                                              .read<AuthenticationBloc>()
                                              .state
                                              .user!
                                              .uid)),
                                  ),
                                ], child: const WeightGraphScreen());
                              }),
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(CupertinoIcons.chart_bar_alt_fill,
                                size: 30,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<WeightBloc, WeightState>(
                        builder: (context, state) {
                      if (state is GetWeightSuccess) {
                        return Expanded(
                            child: WeightList(
                                weightList: state.weightList,
                                userId:
                                    context.read<MyUserBloc>().state.user!.id));
                      } else if (state is GetWeightLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is DeleteWeightLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is DeleteWeightSuccess) {
                        return Expanded(
                            child: WeightList(
                                weightList: state.weightList,
                                userId:
                                    context.read<MyUserBloc>().state.user!.id));
                      } else {
                        return const Center(
                          child: Text("An error has occured"),
                        );
                      }
                    }),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
