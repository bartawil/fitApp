import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/workout_bloc/workout_bloc.dart';
import 'package:flutter_demo/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutTypeScreen extends StatefulWidget {
  final String title;
  final Color color;

  const WorkoutTypeScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  State<WorkoutTypeScreen> createState() => _WorkoutTypeScreenState();
}

class _WorkoutTypeScreenState extends State<WorkoutTypeScreen> {
  Map<String, List<TextEditingController>> workoutSetsControllers = {};
  Map<String, List<TextEditingController>> workoutRepsControllers = {};

  @override
  void initState() {
    super.initState();
    for (var type in workoutTypes) {
      workoutSetsControllers[type] = [];
      workoutRepsControllers[type] = [];
      for (int i = 0; i < 100; i++) {
        workoutSetsControllers[type]?.add(TextEditingController(text: '3'));
        workoutRepsControllers[type]?.add(TextEditingController(text: '12'));
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
          onPressed: () => Navigator.of(context).pop(),
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
            // return a drop down list with all types of workouts
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
                                          child: Text(
                                            state.workoutsList[j].name
                                                .toUpperCase(),
                                            style: GoogleFonts.playfairDisplay(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Number of sets
                                            Row(
                                              children: [
                                                const Text("Sets:"),
                                                const SizedBox(width: 20),
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
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .remove),
                                                                color: Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
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
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons.add),
                                                                color: Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                            // Number of reps
                                            Row(
                                              children: [
                                                const Text("Reps:"),
                                                const SizedBox(width: 20),
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
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .remove),
                                                                color: Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
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
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons.add),
                                                                color: Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
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
          ],
        ),
      ),
    );
  }
}
