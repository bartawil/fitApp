part of 'authentication_bloc.dart';

// Define an abstract class for Authentication events
@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  // Override the props getter to provide a list of event-specific properties
  @override
  List<Object> get props => [];
}

// Define an AuthenticationUserChanged event
class AuthenticationUserChanged extends AuthenticationEvent {
  final User? user;

  // Constructor for AuthenticationUserChanged event
  const AuthenticationUserChanged(this.user);
}
