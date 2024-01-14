import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_demo/blocs/goals_bloc/goals_bloc.dart';
import 'package:flutter_demo/screens/nutrition/nutrition_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

// ignore: must_be_immutable
class DailyGoalsScreen extends StatefulWidget {
  String userId;
  Goals goals;
  DailyGoalsScreen(this.userId, this.goals, {super.key});

  @override
  State<DailyGoalsScreen> createState() => _DailyGoalsScreenState();
}

class _DailyGoalsScreenState extends State<DailyGoalsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController caloriesCotroller = TextEditingController();
  final TextEditingController waterCotroller = TextEditingController();
  final TextEditingController proteinCotroller = TextEditingController();
  final TextEditingController carbsCotroller = TextEditingController();
  final TextEditingController fatCotroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    caloriesCotroller.text = widget.goals.calories!;
    waterCotroller.text = widget.goals.water!;
    proteinCotroller.text = widget.goals.protein!;
    carbsCotroller.text = widget.goals.carbs!;
    fatCotroller.text = widget.goals.fat!;
  }

  @override
  void dispose() {
    caloriesCotroller.dispose();
    waterCotroller.dispose();
    proteinCotroller.dispose();
    carbsCotroller.dispose();
    fatCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<GoalsBloc, GoalsState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        // Screen Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DAILY',
                              style: GoogleFonts.caveat(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 42,
                              ),
                            ),
                            Text(
                              'GOALS',
                              style: GoogleFonts.caveat(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 42,
                              ),
                            ),
                            Text(
                              'SET UP',
                              style: GoogleFonts.caveat(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 42,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Form
                        // Calories Input
                        TextFormField(
                          controller: caloriesCotroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            labelText: "Calories",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill in this field';
                            } else {
                              try {
                                double weight = double.parse(value);
                                if (weight < 800 || weight > 5000) {
                                  return 'Please enter a valid number';
                                }
                              } catch (e) {
                                return 'Please enter a valid input';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Water Input
                        TextFormField(
                          controller: waterCotroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            labelText: "Water",
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill in this field';
                            } else {
                              try {
                                double weight = double.parse(value);
                                if (weight < 0 || weight > 5) {
                                  return 'Please enter a valid number';
                                }
                              } catch (e) {
                                return 'Please enter a valid input';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Protein Input
                        TextFormField(
                          controller: proteinCotroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            labelText: "Protein",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill in this field';
                            } else {
                              try {
                                double weight = double.parse(value);
                                if (weight < 0 || weight > 300) {
                                  return 'Please enter a valid number';
                                }
                              } catch (e) {
                                return 'Please enter a valid input';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Carbs Input
                        TextFormField(
                          controller: carbsCotroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            labelText: "Carbs",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill in this field';
                            } else {
                              try {
                                double weight = double.parse(value);
                                if (weight < 0 || weight > 500) {
                                  return 'Please enter a valid number';
                                }
                              } catch (e) {
                                return 'Please enter a valid input';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Fat Input
                        TextFormField(
                          controller: fatCotroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            labelText: "Fat",
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please fill in this field';
                            } else {
                              try {
                                double weight = double.parse(value);
                                if (weight < 0 || weight > 200) {
                                  return 'Please enter a valid number';
                                }
                              } catch (e) {
                                return 'Please enter a valid input';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            minimumSize: const Size(double.infinity, 55),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Create a goals from the form values
                              Goals newGoals = widget.goals;
                              newGoals = newGoals.copyWith(
                                calories: caloriesCotroller.text,
                                water: waterCotroller.text,
                                protein: proteinCotroller.text,
                                carbs: carbsCotroller.text,
                                fat: fatCotroller.text,
                              );

                              // update a flag if the user has updated the goals
                              // in order to update the goals collection in firestore
                              if (widget.goals != newGoals) {
                                // call Bloc to update the client goals
                                setState(() {
                                  context.read<GoalsBloc>().add(UpdateGoals(
                                      userId: widget.userId, goals: newGoals));
                                });
                              }
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) => GoalsBloc(
                                          userRepository: context
                                              .read<AuthenticationBloc>()
                                              .userRepository)
                                        ..add(GetGoals(
                                            userId: context
                                                .read<AuthenticationBloc>()
                                                .state
                                                .user!
                                                .uid)),
                                    ),
                                  ],
                                  child: NutritionScreen(widget.userId),
                                );
                              }));
                            }
                          },
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
