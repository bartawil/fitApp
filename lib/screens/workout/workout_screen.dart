import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/workout_bloc/workout_bloc.dart';
import 'package:flutter_demo/screens/workout/exercise_list.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Create a TabController with the desired length (number of tabs)
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the TabController to release resources
    _tabController?.dispose();
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
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            await Future.delayed(const Duration(milliseconds: 150));
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose your workout plan',
                    style: GoogleFonts.caveat(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn),
                      child: Image.asset('assets/images/biceps.png',
                          width: 50, height: 50),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TabBar(
                  labelColor: Theme.of(context).colorScheme.error,
                  labelStyle: GoogleFonts.playfairDisplay(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 22,
                  ),
                  tabs: const [
                    Tab(text: 'I'),
                    Tab(
                      text: 'II',
                    ),
                    Tab(
                      text: 'III',
                    ),
                  ]),
              const SizedBox(height: 20),
              BlocBuilder<WorkoutBloc, WorkoutState>(
                builder: (context, state) {
                  if (state is GetWorkoutGifSuccess) {
                    return Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        ExerciseList(
                          gifUrl: state.gifUrl,
                          numOfExercises: 4,
                        ),
                        ExerciseList(
                          gifUrl: state.gifUrl,
                          numOfExercises: 2,
                        ),
                        ExerciseList(
                          gifUrl: state.gifUrl,
                          numOfExercises: 1,
                        ),
                      ]),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
