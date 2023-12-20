part of 'sign_up_bloc.dart';

// An abstract class representing events related to the user sign-up process.
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

// A concrete event class that represents the requirement to sign up a user.
class SignUpRequired extends SignUpEvent {
  // The user object for which registration is requested.
  final MyUser user;

  // The password associated with the user's registration.
  final String password;

  // Constructor to create a SignUpRequired event with the user and password.
  const SignUpRequired(this.user, this.password);

  @override
  List<Object> get props => [user, password];
}
