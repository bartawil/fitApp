// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

// Import event and state classes generated using the 'part' directive
part 'sign_in_event.dart';
part 'sign_in_state.dart';

// Define the SignInBloc class
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  // Constructor for the SignInBloc
  SignInBloc({
    required UserRepository userRepository,
  })   : _userRepository = userRepository,
        super(SignInInitial()) {
    // Define event handlers for SignInRequired and SignOutRequired events
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess()); 
      try {
        // Attempt to sign in using the UserRepository's signIn method
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess()); 
      } catch (e) {
        log(e.toString()); 
        emit(const SignInFailure()); 
      }
    });
    on<SignOutRequired>((event, emit) async {
      // Log the user out using the UserRepository's logOut method
      await _userRepository.logOut(); 
    });
  }
}
