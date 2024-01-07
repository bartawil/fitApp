part of 'update_user_info_bloc.dart';

abstract class UpdateUserInfoEvent extends Equatable {
  const UpdateUserInfoEvent();

  @override
  List<Object> get props => [];
}

// Define an event class UploadPicture that extends UpdateUserInfoEvent.
class UploadPicture extends UpdateUserInfoEvent {
	final String file;
	final String userId;

	const UploadPicture(this.file, this.userId);

	@override
  List<Object> get props => [file, userId];
}

// Define an event class UpdateUserWeight that extends UpdateUserInfoEvent.
class UpdateUserWeight extends UpdateUserInfoEvent {
  final MyUser user;

  const UpdateUserWeight(this.user);

  @override
  List<Object> get props => [user];
}

// Define an event class UpdateUserInfo that extends UpdateUserInfoEvent.
class UpdateUserInfo extends UpdateUserInfoEvent {
  final MyUser user;
  final bool updateWeightFlg;

  const UpdateUserInfo(this.user, this.updateWeightFlg);

  @override
  List<Object> get props => [user];
}
