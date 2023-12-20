// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// Define the AuthenticationBloc class
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  // Constructor for the AuthenticationBloc
  AuthenticationBloc({
    required UserRepository myUserRepository,
  })   : userRepository = myUserRepository,
        super(const AuthenticationState.unknown()) {
    // Initialize a stream subscription to listen for changes in the user's authentication state
    _userSubscription = userRepository.user.listen((authUser) {
      // Dispatch an event to handle user authentication state changes
      add(AuthenticationUserChanged(authUser));
    });

    // Define an event handler for AuthenticationUserChanged events
    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        // If a user is authenticated, emit an AuthenticationState.authenticated state
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        // If no user is authenticated, emit an AuthenticationState.unauthenticated state
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  // Override the close method to cancel the stream subscription
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
