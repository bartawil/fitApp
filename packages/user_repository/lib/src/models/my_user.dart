// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
	final String id;
	final String email;
	final String firstName;
  final String lastName;
  final String phoneNumber;
  final String age;
  final String height;
  final String weight;
  final String gender;
	String? picture;

	MyUser({
		required this.id,
		required this.email,
		required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
		this.picture,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = MyUser(
		id: '', 
		email: '',
		firstName: '',
    lastName: '', 
    phoneNumber: '',
    age: '',
    height: '',
    weight: '',
    gender: '',
		picture: ''
	);

	/// Modify MyUser parameters
	MyUser copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? age,
    String? height,
    String? weight,
    String? gender,
    String? picture,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
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
      phoneNumber: phoneNumber,
      age: age,
      height: height,
      weight: weight,
      gender: gender,
      picture: picture,
    );
  }

	static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      age: entity.age,
      height: entity.height,
      weight: entity.weight,
      gender: entity.gender,
      picture: entity.picture,
    );
  }


	@override
	List<Object?> get props => [
    id, email, firstName, lastName, phoneNumber, 
    age, height, weight, gender, picture];
	
}