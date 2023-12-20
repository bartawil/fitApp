// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

// Import the event and state classes that are part of this Bloc.
part 'sign_up_event.dart';
part 'sign_up_state.dart';

// Define a Bloc class for handling user sign-up operations.
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  // Constructor for the SignUpBloc.
  SignUpBloc({
    required UserRepository userRepository,
  })   : _userRepository = userRepository,
        // Initialize the Bloc with the initial state 'SignUpInitial'.
        super(SignUpInitial()) {
    // Define event handlers using the 'on' method provided by the Bloc library.

    // Handle the SignUpRequired event, which initiates the user sign-up process.
    on<SignUpRequired>((event, emit) async {
      // Emit a SignUpProcess state to indicate that the sign-up process is in progress.
      emit(SignUpProcess());
      try {
        // Call the UserRepository's signUp method to register the user with the provided credentials.
        MyUser user = await _userRepository.signUp(event.user, event.password);

        // Set user data (if needed) in the UserRepository.
        await _userRepository.setUserData(user);

        // Emit a SignUpSuccess state to indicate that the sign-up was successful.
        emit(SignUpSuccess());
      } on CustomFirebaseAuthException catch (e) {
        // If an exception is caught during sign-up, emit a SignUpFailure state
        // with the error message provided by the exception.
        emit(SignUpFailure(e.message.toString()));
      }
    });
  }
}
