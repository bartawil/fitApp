// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'my_user_event.dart';
part 'my_user_state.dart';

// A Bloc responsible for managing the state of a user's profile information.
class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
	final UserRepository _userRepository;

  MyUserBloc({
		required UserRepository myUserRepository
	}) : _userRepository = myUserRepository,
		super(const MyUserState.loading()) {
    on<GetMyUser>((event, emit) async {
      try {
				// Fetch the user's profile information from the repository.
				MyUser myUser = await _userRepository.getMyUser(event.myUserId);
        emit(MyUserState.success(myUser));
      } catch (e) {
			// Log any errors that occur during the process.
			log(e.toString());
			// Notify the state that an error occurred.
			emit(const MyUserState.failure());
      }
    });
  }
}
