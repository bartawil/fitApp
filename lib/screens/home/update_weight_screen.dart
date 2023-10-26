import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/get_weight_bloc/get_weight_bloc_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:flutter_demo/components/constants.dart';
import 'package:flutter_demo/components/text_field.dart';
import 'package:flutter_demo/components/weight_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

class UpdateWeightScreen extends StatefulWidget {
  const UpdateWeightScreen({super.key});

  @override
  State<UpdateWeightScreen> createState() => _UpdateWeightScreenState();
}

class _UpdateWeightScreenState extends State<UpdateWeightScreen> {
  final _formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  double? prvWeight;
  double? newWeight;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UpdateUserWeightSuccess) {
          prvWeight = newWeight;
          context.read<GetWeightBloc>().add(GetWeightList(context.read<MyUserBloc>().state.user!.id));
        } else if (state is UpdateUserWeightLoading) {
          const Center(
            child: CircularProgressIndicator(),
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
              onPressed: () => Navigator.of(context).pop(),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          body: BlocBuilder<MyUserBloc, MyUserState>(builder: (context, state) {
            prvWeight = double.tryParse(state.user?.weight ?? '') ?? 0.0;
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: weightController,
                        hintText: 'Enter your text here',
                        obscureText: false,
                        keyboardType: TextInputType.number,
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
                        }
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        MyUser? user = state.user;
                        user = user!.copyWith(
                          weight: weightController.text,
                        );
                        setState(() {
                          context.read<UpdateUserInfoBloc>().add(UpdateUserWeight(
                            user!,
                          ));
                        });
                      }
                    },
                    style: TextButton.styleFrom (
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
                    )
                  ),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Weights history',
                              style: GoogleFonts.playfairDisplay (
                                color: Theme.of(context).colorScheme.onBackground,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<GetWeightBloc, GetWeightState>(
                    builder: (context, state) {
                      if (state is GetWeightSuccess) {
                        return Expanded(child: WeightList(weightList: state.weightList));
                      } else if (state is GetWeightLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Center(
                          child: Text("An error has occured"),
                        );
                      }
                    }
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}