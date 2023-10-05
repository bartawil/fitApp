part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordRequired extends ResetPasswordEvent {
	final String email;

	const ResetPasswordRequired(this.email);
}