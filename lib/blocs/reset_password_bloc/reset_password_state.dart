part of 'reset_password_bloc.dart';

/// Abstract base class for all possible states in the ResetPasswordBloc.
@immutable
abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of the password reset process.
class ResetPasswordInitial extends ResetPasswordState {}

/// Represents the state when the password reset is successful.
class ResetPasswordSuccess extends ResetPasswordState {}

/// Represents the state when the password reset has failed.
class ResetPasswordFailure extends ResetPasswordState {
  final String? message;

  /// Constructor for ResetPasswordFailure with an optional error message.
  const ResetPasswordFailure(this.message);
}

/// Represents the state when the password reset is in progress.
class ResetPasswordProcess extends ResetPasswordState {}
