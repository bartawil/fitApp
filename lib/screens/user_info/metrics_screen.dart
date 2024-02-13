import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:fitapp/blocs/measurements_bloc/measurements_bloc.dart';
import 'package:fitapp/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:fitapp/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:fitapp/blocs/weight_bloc/weight_bloc.dart';
import 'package:fitapp/screens/user_info/measurements_screen.dart';
import 'package:fitapp/screens/weight/update_weight_screen.dart';
import 'package:fitapp/screens/weight/weight_graph_screen.dart';
import 'package:google_fonts/google_fonts.dart';

/// MetricsScreen for helping the user to track their progress
class MetricsScreen extends StatefulWidget {
  const MetricsScreen({super.key});

  @override
  State<MetricsScreen> createState() => _MetricsScreenState();
}

class _MetricsScreenState extends State<MetricsScreen> {
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
            // Title
            Center(
              child: Column(
                children: [
                  Text(
                    'TRACK',
                    style: GoogleFonts.playfairDisplay(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 42,
                    ),
                  ),
                  Text(
                    'YOUR',
                    style: GoogleFonts.playfairDisplay(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 42,
                    ),
                  ),
                  Text(
                    'PROGRESS',
                    style: GoogleFonts.playfairDisplay(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 42,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            // Buttons
            BlocBuilder<MyUserBloc, MyUserState>(builder: (context, state) {
              if (state.user != null) {
                return Column(
                  children: [
                    Column(
                      children: [
                        // Measurements button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => MeasurementsBloc(
                                        userRepository: context
                                            .read<AuthenticationBloc>()
                                            .userRepository)
                                      ..add(GetMeasurementsList(
                                          userId: context
                                              .read<AuthenticationBloc>()
                                              .state
                                              .user!
                                              .uid)),
                                  ),
                                ],
                                child: MeasurementsScreen(userId: context
                                            .read<AuthenticationBloc>()
                                            .state
                                            .user!
                                            .uid),
                              );
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            minimumSize: const Size(280, 80),
                          ),
                          child: Text(
                            'MEASUREMENTS',
                            style: GoogleFonts.caveat(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Charts button
                        ElevatedButton(
                          onPressed: () {
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
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(
                                280, 80), // Set the desired width and height
                          ),
                          child: Text(
                            'CHARTS',
                            style: GoogleFonts.caveat(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Update Weight button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MultiBlocProvider(
                                providers: [
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
                                  BlocProvider(
                                    create: (context) => UpdateUserInfoBloc(
                                        userRepository: context
                                            .read<AuthenticationBloc>()
                                            .userRepository),
                                  ),
                                  BlocProvider(
                                    create: (context) => WeightBloc(
                                        userRepository: context
                                            .read<AuthenticationBloc>()
                                            .userRepository)
                                      ..add(GetWeightList(context
                                          .read<AuthenticationBloc>()
                                          .state
                                          .user!
                                          .uid)),
                                  ),
                                ],
                                child: const UpdateWeightScreen(),
                              );
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                            minimumSize: const Size(
                                280, 80), // Set the desired width and height
                          ),
                          child: Text(
                            'WEIGHT',
                            style: GoogleFonts.caveat(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ],
        ));
  }
}
