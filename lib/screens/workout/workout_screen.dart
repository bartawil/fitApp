import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:fitapp/blocs/workout_bloc/workout_bloc.dart';
import 'package:fitapp/screens/workout/exercise_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';
import 'package:workout_repository/workout_repository.dart';

class WorkoutScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const WorkoutScreen({Key? key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose your workout plan',
                    style: GoogleFonts.caveat(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Image.asset(
                    'assets/images/biceps.png',
                    width: 50,
                    height: 50,// Apply a custom color filter
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TabBar(
                controller: _tabController,
                labelColor: const Color.fromARGB(255, 202, 99, 99), // Set a custom label color
                labelStyle: GoogleFonts.playfairDisplay(
                  color: Colors.white, // Set a custom label font color
                  fontSize: 22,
                ),
                tabs: const [
                  Tab(text: 'I'),
                  Tab(text: 'II'),
                  Tab(text: 'III'),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<MyUserBloc, MyUserState>(
                builder: (context, state) {
                  if (state.status == MyUserStatus.success) {
                    return Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Workout 1
                          MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => WorkoutBloc(
                                  userRepository: FirebaseUserRepository(),
                                  workoutRepository:
                                      FirebaseWorkoutRepository(),
                                )..add(GetUserWorkoutList(state.user!.id, 1)),
                              ),
                            ],
                            child: ExerciseList(),
                          ),
                          // Workout 2
                          MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => WorkoutBloc(
                                  userRepository: FirebaseUserRepository(),
                                  workoutRepository:
                                      FirebaseWorkoutRepository(),
                                )..add(GetUserWorkoutList(state.user!.id, 2)),
                              ),
                            ],
                            child: ExerciseList(),
                          ),
                          // Workout 3
                          MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => WorkoutBloc(
                                  userRepository: FirebaseUserRepository(),
                                  workoutRepository:
                                      FirebaseWorkoutRepository(),
                                )..add(GetUserWorkoutList(state.user!.id, 3)),
                              ),
                            ],
                            child: ExerciseList(),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}