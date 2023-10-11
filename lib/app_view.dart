import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/get_post_bloc/get_post_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:flutter_demo/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_demo/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_demo/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:flutter_demo/screens/authentication/welcome_screen.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'screens/home/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'fitApp',
			theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          onBackground: Color.fromARGB(255, 40, 23, 23),
          primary: Color.fromRGBO(206, 147, 216, 1),
          onPrimary: Colors.black,
          secondary: Color.fromRGBO(244, 143, 177, 1),
          onSecondary: Colors.white,
					tertiary: Color.fromRGBO(255, 204, 128, 1),
          error: Colors.red,
					outline: Color(0xFF424242)
        ),
			),
			home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
				builder: (context, state) {
					if (state.status == AuthenticationStatus.authenticated) {
						return MultiBlocProvider(
								providers: [
									BlocProvider(
										create: (context) => SignInBloc(
											userRepository: context.read<AuthenticationBloc>().userRepository
										),
									),
									BlocProvider(
										create: (context) => UpdateUserInfoBloc(
											userRepository: context.read<AuthenticationBloc>().userRepository
										),
									),
									BlocProvider(
										create: (context) => MyUserBloc(
											myUserRepository: context.read<AuthenticationBloc>().userRepository
										)..add(GetMyUser(
											myUserId: context.read<AuthenticationBloc>().state.user!.uid
										)),
									),
									BlocProvider(
										create: (context) => GetPostBloc(
											postRepository: FirebasePostRepository()
										)..add(GetPosts())
									),
								],
							child: const HomeScreen(),
						);
					} else {
						return const WelcomeScreen();
					}
				}
			),
		);
  }
}