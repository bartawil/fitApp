// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_info_event.dart';
part 'update_user_info_state.dart';

class UpdateUserInfoBloc extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
  final UserRepository _userRepository;

  UpdateUserInfoBloc({
		required UserRepository userRepository
	}) : 	_userRepository = userRepository, 
	super(UpdateUserInfoInitial()) {
    // Define an event handler for the UploadPicture event.
    on<UploadPicture>((event, emit) async {
			emit(UploadPictureLoading());
      try {
				String userImage = await _userRepository.uploadPicture(event.file, event.userId);
        emit(UploadPictureSuccess(userImage));
      } catch (e) {
        emit(UploadPictureFailure());
      }
    });

    // Define an event handler for the UpdateUser event.
    on<UpdateUserWeight>((event, emit) async {
      emit(UpdateUserWeightLoading());
      try {
        await _userRepository.setUserData(event.user);
        await _userRepository.createWeightCollection(event.user.weight, event.user.id);
        emit(UpdateUserWeightSuccess());
      } catch (e) {
        emit(UpdateUserWeightFailure());
      }
    });

    // Define an event handler for the UpdateUser event.
    on<UpdateUserInfo>((event, emit) async {
      emit(UpdateUserInfoLoading());
      try {
        await _userRepository.setUserData(event.user);
        if (event.updateWeightFlg) {
          // update the wight if and only if the user has updated the weight
          await _userRepository.createWeightCollection(event.user.weight, event.user.id);
        }
        emit(UpdateUserInfoSuccess());
      } catch (e) {
        emit(UpdateUserInfoFailure());
      }
    });
  }
}
