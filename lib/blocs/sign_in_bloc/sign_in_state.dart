part of 'sign_in_bloc.dart';

// Define an abstract class for SignIn states
@immutable
abstract class SignInState extends Equatable {
  const SignInState();

  // Override the props getter to provide a list of state-specific properties
  @override
  List<Object> get props => [];
}

// Define a SignInInitial state
class SignInInitial extends SignInState {}

// Define a SignInSuccess state
class SignInSuccess extends SignInState {}

// Define a SignInFailure state
class SignInFailure extends SignInState {
  final String? message;

  // Constructor for SignInFailure state with an optional error message
  const SignInFailure({this.message});
}

// Define a SignInProcess state
class SignInProcess extends SignInState {}
