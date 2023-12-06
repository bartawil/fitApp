import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/workout_bloc/workout_bloc.dart';
import 'package:flutter_demo/screens/workout/trainer/workout_type_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';
import 'package:workout_repository/workout_repository.dart';

class PlanWorkoutScreen extends StatefulWidget {
  const PlanWorkoutScreen({super.key});

  @override
  State<PlanWorkoutScreen> createState() => _PlanWorkoutScreenState();
}

class _PlanWorkoutScreenState extends State<PlanWorkoutScreen> {
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
      body: Column(
        children: [
          const SizedBox(height: 50),
          Center(
            child: Column(
              children: [
                Text(
                  'BUILD',
                  style: GoogleFonts.playfairDisplay(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 42,
                  ),
                ),
                Text(
                  'WORKOUT',
                  style: GoogleFonts.playfairDisplay(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 42,
                  ),
                ),
                Text(
                  'PLAN',
                  style: GoogleFonts.playfairDisplay(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 42,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          BlocBuilder<MyUserBloc, MyUserState>(builder: (context, state) {
            if (state.user != null) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => WorkoutBloc(
                                    userRepository: FirebaseUserRepository(),
                                    workoutRepository:
                                        FirebaseWorkoutRepository()),
                              ),
                            ],
                            child: WorkoutTypeScreen(
                              userId: state.user!.id,
                              workoutNumber: 1,
                              title: 'CHOOSE WORKOUT   I',
                              color: Theme.of(context).colorScheme.secondary,
                            ));
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      minimumSize: const Size(
                          280, 80), // Set the desired width and height
                    ),
                    child: Text(
                      'CHOOSE WORKOUT   I',
                      style: GoogleFonts.caveat(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => WorkoutBloc(
                                    userRepository: FirebaseUserRepository(),
                                    workoutRepository:
                                        FirebaseWorkoutRepository()),
                              ),
                            ],
                            child: WorkoutTypeScreen(
                              userId: state.user!.id,
                              workoutNumber: 2,
                              title: 'CHOOSE WORKOUT   II',
                              color: Theme.of(context).colorScheme.primary,
                            ));
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                          280, 80), // Set the desired width and height
                    ),
                    child: Text(
                      'CHOOSE WORKOUT   II',
                      style: GoogleFonts.caveat(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => WorkoutBloc(
                                    userRepository: FirebaseUserRepository(),
                                    workoutRepository:
                                        FirebaseWorkoutRepository()),
                              ),
                            ],
                            child: WorkoutTypeScreen(
                              userId: state.user!.id,
                              workoutNumber: 3,
                              title: 'CHOOSE WORKOUT   III',
                              color: Theme.of(context).colorScheme.scrim,
                            ));
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.scrim,
                      minimumSize: const Size(
                          280, 80), // Set the desired width and height
                    ),
                    child: Text(
                      'CHOOSE WORKOUT   III',
                      style: GoogleFonts.caveat(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ],
      ),
    );
  }
}
