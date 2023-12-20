import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_demo/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:flutter_demo/screens/authentication/welcome_screen.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'screens/home/home_screen.dart';

// This is the main application widget.
class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  @override
  Widget build(BuildContext context) {
    // MaterialApp is a widget that configures the top-level of your app.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fitApp',
      // Define the app's colors and theme.
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Color.fromARGB(255, 243, 245, 243),
          onBackground: Color.fromARGB(255, 40, 23, 23),
          primary: Color.fromRGBO(56, 2, 59, 1),
          onPrimary: Colors.white,
          secondary: Color.fromARGB(90, 118, 132, 1),
          onSecondary: Colors.black,
          tertiary: Color.fromRGBO(26, 34, 22, 1),
          error: Color.fromRGBO(217, 178, 178, 1),
          outline: Color(0xFF424242),
        ),
      ),
      // Define the initial screen based on the authentication status.
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // If the user is authenticated, build the home screen.
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                // BlocProvider for the SignInBloc.
                BlocProvider(
                  create: (context) => SignInBloc(
                    userRepository: context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
                // BlocProvider for the UpdateUserInfoBloc.
                BlocProvider(
                  create: (context) => UpdateUserInfoBloc(
                    userRepository: context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
                // BlocProvider for the MyUserBloc, and dispatching a GetMyUser event.
                BlocProvider(
                  create: (context) => MyUserBloc(
                    myUserRepository: context.read<AuthenticationBloc>().userRepository,
                  )..add(GetMyUser(
                      myUserId: context.read<AuthenticationBloc>().state.user!.uid,
                    )),
                ),
              ],
              child: const HomeScreen(),
            );
          } else {
            // If the user is not authenticated, show the Sign-in\up options on WelcomeScreen.
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
