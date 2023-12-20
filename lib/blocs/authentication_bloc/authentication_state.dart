part of 'authentication_bloc.dart';

// Enum to represent different authentication statuses
enum AuthenticationStatus { authenticated, unauthenticated, unknown }

// Define the AuthenticationState class
class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;

  // Private constructor for AuthenticationState
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  /// Create an AuthenticationState with an unknown status.
  const AuthenticationState.unknown() : this._();

  /// Create an AuthenticationState with an authenticated status.
  /// It takes a [User] property representing the current authenticated user.
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  /// Create an AuthenticationState with an unauthenticated status.
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  // Override the props getter to provide a list of object properties to be compared for equality
  @override
  List<Object?> get props => [status, user];
}
