part of 'sign_up_bloc.dart';

// An abstract class representing various states related to the user sign-up process.
abstract class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

// Represents the initial state of the sign-up process.
class SignUpInitial extends SignUpState {}

// Represents a state indicating successful user registration.
class SignUpSuccess extends SignUpState {}

// Represents a state indicating a failure during user registration, with an optional error message.
class SignUpFailure extends SignUpState {
  // The error message describing the reason for registration failure.
  final String? message;

  // Constructor to create a SignUpFailure state with an optional error message.
  const SignUpFailure(this.message);
}

// Represents a state indicating that the sign-up process is in progress.
class SignUpProcess extends SignUpState {}
