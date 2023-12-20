import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/workout_bloc/workout_bloc.dart';
import 'package:flutter_demo/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';


/// This widget represents the screen for selecting and configuring exercises for a workout plan.
class SelectExerciseScreen extends StatefulWidget {
  final String userId;
  final double workoutNumber;
  final String title;
  final Color color;

  const SelectExerciseScreen(
      {Key? key,
      required this.userId,
      required this.workoutNumber,
      required this.title,
      required this.color})
      : super(key: key);

  @override
  State<SelectExerciseScreen> createState() => _SelectExerciseScreenState();
}

class _SelectExerciseScreenState extends State<SelectExerciseScreen> {
  // Controllers for managing workout sets and reps
  Map<String, List<TextEditingController>> workoutSetsControllers = {};
  Map<String, List<TextEditingController>> workoutRepsControllers = {};

  // Selected workouts and their IDs
  Map<String, List<bool>> selectedWorkouts = {};
  Map<String, List<String>> selectedId = {};

  // List of user workouts
  List<UserWorkout> userWorkoutsList = [];


  @override
  void initState() {
    super.initState();
    // Initialize controllers and lists
    for (var type in workoutTypes) {
      workoutSetsControllers[type] = [];
      workoutRepsControllers[type] = [];
      selectedWorkouts[type] = [];
      selectedId[type] = [];
      for (int i = 0; i < 100; i++) {
        workoutSetsControllers[type]?.add(TextEditingController(text: '3'));
        workoutRepsControllers[type]?.add(TextEditingController(text: '12'));
        selectedWorkouts[type]?.add(false);
        selectedId[type]?.add('');
      }
    }
  }

  // Handle saving user workouts
  void onReturnFromScreen() {
    for (var type in workoutTypes) {
      for (int i = 0; i < 100; i++) {
        if (selectedWorkouts[type]![i]) {
          log('type: $type index: ${selectedId[type]![i]}',
              name: "SelectExerciseScreen");
          log('type: $type index: $i', name: "SelectExerciseScreen");
          UserWorkout userWorkout = UserWorkout.empty;
          userWorkout.workoutId = selectedId[type]![i];
          userWorkout.category = type;
          userWorkout.workoutNumber = widget.workoutNumber;
          userWorkout.sets =
              double.parse(workoutSetsControllers[type]![i].text);
          userWorkout.reps =
              double.parse(workoutRepsControllers[type]![i].text);
        context.read<WorkoutBloc>().add(UpdateUserWorkout(
            widget.userId, 
            selectedId[type]![i],
            type,
            widget.workoutNumber,
            double.parse(workoutSetsControllers[type]![i].text),
            double.parse(workoutRepsControllers[type]![i].text),
        ));
          
        }
      }
    }
  }

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    for (var type in workoutTypes) {
      for (var controller in workoutSetsControllers[type]!) {
        controller.dispose();
      }
      for (var controller in workoutRepsControllers[type]!) {
        controller.dispose();
      }
    }
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          children: [
            Container(
              width: 280,
              height: 80,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: GoogleFonts.caveat(
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Return a drop-down list with all types of workouts
            Expanded(
              child: ListView.builder(
                itemCount: workoutTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.005),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: ExpansionTile(
                        title: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.005),
                          ),
                          width: 100,
                          height: 50,
                          child: Text(
                            '${workoutTypes[index]} Workout',
                            style: GoogleFonts.caveat(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        onExpansionChanged: (bool ex) {
                          context
                              .read<WorkoutBloc>()
                              .add(GetWorkoutsList(workoutTypes[index]));
                        },
                        // Inside ExpansionTile's children
                        children: [
                          BlocBuilder<WorkoutBloc, WorkoutState>(
                            builder: (context, state) {
                              if (state is GetWorkoutsListLoading) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder: (BuildContext context, int j) {
                                    return const ListTile(
                                      title: Text(' '),
                                    );
                                  },
                                );
                              } else if (state is GetWorkoutsListSuccess) {
                                Future.delayed(const Duration(seconds: 10));
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.workoutsList.length,
                                  itemBuilder: (BuildContext context, int j) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey[300]!,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 8.0),
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state.workoutsList[j].name
                                                    .toUpperCase(),
                                                style:
                                                    GoogleFonts.playfairDisplay(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Checkbox(
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .error,
                                                value: selectedWorkouts[
                                                    workoutTypes[index]]![j],
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedWorkouts[
                                                            workoutTypes[
                                                                index]]![j] =
                                                        value!;
                                                    selectedId[workoutTypes[
                                                            index]]![j] =
                                                        state
                                                            .workoutsList[j].id;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Number of sets
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                workoutSetsControllers[
                                                                        workoutTypes[
                                                                            index]]![j]
                                                                    .text,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                child:
                                                                    IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .remove),
                                                                  color: Colors
                                                                      .white,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      workoutSetsControllers[workoutTypes[index]]![
                                                                              j]
                                                                          .text = (int.parse(workoutSetsControllers[workoutTypes[index]]![j].text) -
                                                                              1)
                                                                          .toString();
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              CircleAvatar(
                                                                backgroundColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                child:
                                                                    IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .add),
                                                                  color: Colors
                                                                      .white,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      workoutSetsControllers[workoutTypes[index]]![
                                                                              j]
                                                                          .text = (int.parse(workoutSetsControllers[workoutTypes[index]]![j].text) +
                                                                              1)
                                                                          .toString();
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      const Text("Sets"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              // Number of reps
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                workoutRepsControllers[
                                                                        workoutTypes[
                                                                            index]]![j]
                                                                    .text,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                child:
                                                                    IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .remove),
                                                                  color: Colors
                                                                      .white,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      workoutRepsControllers[workoutTypes[index]]![
                                                                              j]
                                                                          .text = (int.parse(workoutRepsControllers[workoutTypes[index]]![j].text) -
                                                                              1)
                                                                          .toString();
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              CircleAvatar(
                                                                backgroundColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                child:
                                                                    IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .add),
                                                                  color: Colors
                                                                      .white,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      workoutRepsControllers[workoutTypes[index]]![
                                                                              j]
                                                                          .text = (int.parse(workoutRepsControllers[workoutTypes[index]]![j].text) +
                                                                              1)
                                                                          .toString();
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      const Text("Reps"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text("Error loading workouts"),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                onReturnFromScreen();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                minimumSize: const Size(150, 50), // Set the desired width and height
              ),
              child: const Text('Save workout'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
