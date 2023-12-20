part of 'my_user_bloc.dart';

// An abstract class representing events that can occur in the MyUserBloc.
abstract class MyUserEvent extends Equatable {
  const MyUserEvent();

  @override
  List<Object> get props => [];
}

// A specific event to fetch a user's profile information by their user ID.
class GetMyUser extends MyUserEvent {
	final String myUserId;

	// Constructor to initialize the GetMyUser event with a user ID.
	const GetMyUser({required this.myUserId});

	// Override the props getter to include the myUserId in the list of properties.
  @override
  List<Object> get props => [myUserId];
}
