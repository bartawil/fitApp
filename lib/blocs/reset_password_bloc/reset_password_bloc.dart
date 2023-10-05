import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
	final UserRepository _userRepository;
	
  ResetPasswordBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
		super(ResetPasswordInitial()) {
    on<ResetPasswordRequired>((event, emit) async {
			emit(ResetPasswordProcess());
      try {
        await _userRepository.resetPassword(event.email);
				emit(ResetPasswordSuccess());
      } on CustomFirebaseAuthException catch (e) {
        log(e.toString());
				emit(ResetPasswordFailure(e.message.toString()));
      }
    });
  }
}
