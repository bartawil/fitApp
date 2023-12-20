import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'app_view.dart';

// MyApp class, a StatefulWidget representing the main application widget
class MyApp extends StatefulWidget {
  // UserRepository instance to be passed to MyApp
  final UserRepository userRepository;

  // Constructor for MyApp class that takes a UserRepository as a parameter
  const MyApp(this.userRepository, {super.key});

  @override
  // Create and return the state for MyApp
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

// State class for MyApp widget
class _MyAppState extends State<MyApp> {
  // Declare an instance of AuthenticationBloc
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    // Initialize the AuthenticationBloc with the UserRepository
    _authenticationBloc = AuthenticationBloc(myUserRepository: widget.userRepository);
  }

  @override
  void dispose() {
    // Close the AuthenticationBloc to prevent memory leaks
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      // Provide the AuthenticationBloc instance to the widget tree
      providers: [
        RepositoryProvider<AuthenticationBloc>.value(value: _authenticationBloc),
      ],
      // Create and return a MyAppView widget as the main content
      child: const MyAppView(),
    );
  }
}
