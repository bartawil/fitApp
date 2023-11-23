import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_demo/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_demo/blocs/weight_bloc/weight_bloc.dart';
import 'package:flutter_demo/blocs/workout_bloc/workout_bloc.dart';
import 'package:flutter_demo/components/menu_button.dart';
import 'package:flutter_demo/screens/home/settings_screen.dart';
import 'package:flutter_demo/screens/weight/update_weight_screen.dart';
import 'package:flutter_demo/screens/weight/weight_graph_screen.dart';
import 'package:flutter_demo/screens/workout/workout_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_repository/workout_repository.dart';

import '../../blocs/my_user_bloc/my_user_bloc.dart';
import '../../blocs/update_user_info_bloc/update_user_info_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<MyUserBloc>().state.user!.picture = state.userImage;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          // Profile image and title
          title: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                return Row(
                  children: [
                    const SizedBox(width: 12),
                    Text(
                      "Welcome ${state.user!.firstName} !",
                      style: GoogleFonts.playfairDisplay(
                        color: Theme.of(context).colorScheme.onBackground,
                        // fontSize: 32,
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          // Sign-Out button
          // Drawer button
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Transform.rotate(
                  angle: 0.0, // set the angle of rotation
                  child: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
        ),
        endDrawer: Drawer(
          width: 250,
          shadowColor: Theme.of(context).colorScheme.primary,
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.primary,
                              BlendMode.srcIn),
                          child: Image.asset('assets/images/dumbel.png',
                              width: 80, height: 80),
                        ),
                      ),
                      Text(
                        'FITAPP',
                        style: GoogleFonts.playfairDisplay(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.chart_bar_alt_fill,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
                  title: Text(
                    "Progress Charts",
                    style: GoogleFonts.caveat(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
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
                ),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.settings_solid,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
                  title: Text(
                    "App Settings",
                    style: GoogleFonts.caveat(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
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
                          ],
                          child: const SettingsScreen(),
                        );
                      }),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.fitness_center_sharp,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
                  title: Text(
                    "Workouts",
                    style: GoogleFonts.caveat(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => WorkoutBloc(
                                workoutRepository:  FirebaseWorkoutRepository())
                              ..add(const GetWorkoutGif()),
                          ),
                        ],
                        child: const WorkoutScreen(),
                      );
                    }));
                  },
                ),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.square_arrow_right,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                  ),
                  title: Text(
                    "Sign Out",
                    style: GoogleFonts.caveat(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 24,
                    ),
                  ),
                  onTap: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  },
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                    child: Image.asset('assets/images/dumbel.png',
                        width: 200, height: 150),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FITAPP',
                    style: GoogleFonts.playfairDisplay(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 52,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            // Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyMenuButton(
                  title: "Workouts",
                  icon: 'assets/images/muscle.png',
                  iconColor: Theme.of(context).colorScheme.onBackground,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => WorkoutBloc(
                                workoutRepository: FirebaseWorkoutRepository())
                              ..add(const GetWorkoutGif()),
                          ),
                        ],
                        child: const WorkoutScreen(),
                      );
                    }));
                  },
                ),
                const SizedBox(width: 30),
                MyMenuButton(
                    title: "settings",
                    icon: 'assets/images/settings.png',
                    iconColor: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.5),
                    onTap: () {
                      Navigator.push(
                        context,
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
                            ],
                            child: const SettingsScreen(),
                          );
                        }),
                      );
                    },
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    fontColor: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.5)),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyMenuButton(
                  title: "Metrics",
                  icon: 'assets/images/weight.png',
                  iconColor: Theme.of(context).colorScheme.secondary,
                  onTap: () {
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
                ),
                const SizedBox(width: 30),
                MyMenuButton(
                  title: "Nutrintion",
                  icon: 'assets/images/nutritional.png',
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
