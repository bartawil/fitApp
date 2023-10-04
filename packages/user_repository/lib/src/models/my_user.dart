import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
	final String id;
	final String email;
	final String firstName;
  final String lastName;
	String? picture;

	MyUser({
		required this.id,
		required this.email,
		required this.firstName,
    required this.lastName,
		this.picture,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = MyUser(
		id: '', 
		email: '',
		firstName: '',
    lastName: '', 
		picture: ''
	);

	/// Modify MyUser parameters
	MyUser copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? picture,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      picture: picture ?? this.picture,
    );
  }

	/// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;

	MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      picture: picture,
    );
  }

	static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      picture: entity.picture,
    );
  }


	@override
	List<Object?> get props => [id, email, firstName, lastName, picture];
	
}