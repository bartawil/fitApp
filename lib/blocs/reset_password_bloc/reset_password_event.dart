part of 'reset_password_bloc.dart';

// Abstract class representing events related to resetting a password
abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent(); // Constructor

  @override
  List<Object> get props => []; 
}

// Event class indicating that a password reset is required
class ResetPasswordRequired extends ResetPasswordEvent {
  final String email; // Email address for password reset

  // Constructor for the ResetPasswordRequired event
  const ResetPasswordRequired(this.email);

  @override
  List<Object> get props => [email]; 
}