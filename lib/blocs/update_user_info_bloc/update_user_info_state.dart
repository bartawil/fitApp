part of 'update_user_info_bloc.dart';

abstract class UpdateUserInfoState extends Equatable {
  const UpdateUserInfoState();
  
  @override
  List<Object> get props => [];
}

class UpdateUserInfoInitial extends UpdateUserInfoState {}

// Define state classes related to the UploadPicture event.
class UploadPictureFailure extends UpdateUserInfoState {}
class UploadPictureLoading extends UpdateUserInfoState {}
class UploadPictureSuccess extends UpdateUserInfoState {
	final String userImage;

	const UploadPictureSuccess(this.userImage);

	@override
  List<Object> get props => [userImage];
}

// Define state classes related to the UpdateUserWeight event.
class UpdateUserWeightFailure extends UpdateUserInfoState {}
class UpdateUserWeightLoading extends UpdateUserInfoState {}
class UpdateUserWeightSuccess extends UpdateUserInfoState {}

// Define state classes related to the UpdateUserInfo event.
class UpdateUserInfoFailure extends UpdateUserInfoState {}
class UpdateUserInfoLoading extends UpdateUserInfoState {}
class UpdateUserInfoSuccess extends UpdateUserInfoState {}