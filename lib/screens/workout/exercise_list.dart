// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/workout_bloc/workout_bloc.dart';
import 'package:gif_view/gif_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';
import 'package:workout_repository/workout_repository.dart';

// Define the ExerciseList widget as a StatefulWidget
class ExerciseList extends StatefulWidget {
  ExerciseList({Key? key}) : super(key: key);

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

// Create the state for the ExerciseList widget
class _ExerciseListState extends State<ExerciseList> with SingleTickerProviderStateMixin {
  List<UserWorkout> userWorkoutList = []; 
  // List of GifControllers for GIF animations
  final List<GifController> controllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize GifControllers for animations
    for (int i = 0; i < 10; i++) {
      controllers.add(GifController(autoPlay: false));
    }
  }

  @override
  void dispose() {
    // Dispose of GifControllers to release resources
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
      builder: (context, state) {
        if (state is GetUserWorkoutListSuccess) {
          userWorkoutList = state.userWorkoutList;
          return ListView.builder(
            itemCount: state.userWorkoutList.length,
            itemBuilder: (context, int i) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => WorkoutBloc(
                        userRepository: FirebaseUserRepository(),
                        workoutRepository: FirebaseWorkoutRepository())
                      ..add(GetWorkoutById(userWorkoutList[i].category,
                          userWorkoutList[i].workoutId)),
                  ),
                ],
                child: BlocBuilder<WorkoutBloc, WorkoutState>(
                  builder: (context, state) {
                    if (state is GetWorkoutByIdSuccess) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[300]!,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(
                              top: 0.0,
                              bottom: 10.0,
                              left: 0.0,
                              right: 0.0,
                            ),
                            title: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      for (int j = 0;
                                          j < controllers.length;
                                          j++) {
                                        if (j == i) {
                                          if (controllers[j].status ==
                                              GifStatus.playing) {
                                            controllers[j].pause();
                                          } else {
                                            controllers[j].play();
                                          }
                                        } else {
                                          controllers[j].pause();
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              state.workout.gifUrl,
                                            ),
                                            fit: BoxFit.cover),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      // child: ClipRRect(
                                      //   borderRadius: BorderRadius.circular(8),
                                      //   child: GifView.network(
                                      //     state.workout.gifUrl,
                                      //     height: 100,
                                      //     width: 100,
                                      //     controller: controllers[i],
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            220, // Set the desired width for the text
                                        child: Text(
                                          state.workout.name.toUpperCase(),
                                          style: GoogleFonts.playfairDisplay(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Text(
                                        'Sets: ${userWorkoutList[i].sets.toInt()}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Reps: ${userWorkoutList[i].reps.toInt()}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: Text(''),
                    );
                  },
                ),
              );
            },
          );
        }
        return const Center(
          child: Text(''),
        );
      },
    );
  }
}
