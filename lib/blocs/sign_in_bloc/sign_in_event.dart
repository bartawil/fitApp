part of 'sign_in_bloc.dart';

// Define an abstract class for SignIn events
abstract class SignInEvent extends Equatable {
  const SignInEvent();

  // Override the props getter to provide a list of event-specific properties
  @override
  List<Object> get props => [];
}

// Define a SignInRequired event
class SignInRequired extends SignInEvent {
  final String email;
  final String password;

  // Constructor for SignInRequired event
  const SignInRequired(this.email, this.password);
}

// Define a SignOutRequired event
class SignOutRequired extends SignInEvent {
  // Constructor for SignOutRequired event
  const SignOutRequired();
}
