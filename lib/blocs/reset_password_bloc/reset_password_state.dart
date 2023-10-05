part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordState extends Equatable {
	const ResetPasswordState();
  
  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordFailure extends ResetPasswordState {
	final String? message;

	ResetPasswordFailure(String? message) : message = message;
}

class ResetPasswordProcess extends ResetPasswordState {}