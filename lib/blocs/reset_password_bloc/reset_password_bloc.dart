// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

// This is the ResetPasswordBloc class, responsible for handling the password reset logic.
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final UserRepository _userRepository; // Instance of the UserRepository.

  // Constructor for the ResetPasswordBloc.
  ResetPasswordBloc({
    required UserRepository userRepository, // UserRepository is required for this BLoC.
  })   : _userRepository = userRepository, // Initialize the UserRepository.
        super(ResetPasswordInitial()) {
    // The super() call initializes the BLoC with an initial state.

    // Define an event handler for the ResetPasswordRequired event.
    on<ResetPasswordRequired>((event, emit) async {
      // This is called when a ResetPasswordRequired event is added to the BLoC.

      emit(ResetPasswordProcess()); // Emit the ResetPasswordProcess state to show progress.

      try {
        // Attempt to reset the password using the UserRepository.
        await _userRepository.resetPassword(event.email);

        // If successful, emit the ResetPasswordSuccess state.
        emit(ResetPasswordSuccess());
      } on CustomFirebaseAuthException catch (e) {
        // If there's an exception (e.g., invalid email), log the error message.
        log(e.toString());

        // Emit the ResetPasswordFailure state with the error message.
        emit(ResetPasswordFailure(e.message.toString()));
      }
    });
  }
}