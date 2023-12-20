part of 'my_user_bloc.dart';

// An enum representing the status of the MyUserBloc.
enum MyUserStatus { success, loading, failure }

// A class representing the state of the MyUserBloc.
class MyUserState extends Equatable {
	final MyUserStatus status; // The status of the MyUserBloc.
  final MyUser? user; // The user's profile information.

  // Private constructor to create a MyUserState with optional parameters.
  const MyUserState._({
    this.status = MyUserStatus.loading, // Default status is loading.
    this.user,
  });

  // Factory constructor to create a loading MyUserState.
  const MyUserState.loading() : this._();

  // Factory constructor to create a successful MyUserState with user data.
  const MyUserState.success(MyUser user) : this._(status: MyUserStatus.success, user: user);

  // Factory constructor to create a failure MyUserState.
  const MyUserState.failure() : this._(status: MyUserStatus.failure);

  @override
  List<Object?> get props => [status, user];
}
