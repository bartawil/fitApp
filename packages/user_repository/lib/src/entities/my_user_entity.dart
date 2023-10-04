import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
	final String id;
	final String email;
	final String firstName;
  final String lastName;
	final String? picture;

	const MyUserEntity({
		required this.id,
		required this.email,
		required this.firstName,
    required this.lastName,
		this.picture,
	});

	Map<String, Object?> toDocument() {
    return {
      'id': id,
			'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'picture': picture,
    };
  }

	static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
			email: doc['email'] as String,
      firstName: doc['first_name'] as String,
      lastName: doc['last_name'] as String,
      picture: doc['picture'] as String?
    );
  }
	
	@override
	List<Object?> get props => [id, email, firstName, lastName, picture];

	@override
  String toString() {
    return '''UserEntity: {
      id: $id
      email: $email
      first_name: $firstName
      last_name: $lastName
      picture: $picture
    }''';
  }
}