// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class WorkoutEntity extends Equatable {
	String name;
  String category;
  String gifUrl;


	WorkoutEntity({
		required this.name,
    required this.category,
    required this.gifUrl,
	});

	Map<String, Object?> toDocument() {
    return {
      'name': name,
      'category': category,
      'gifUrl': gifUrl,
    };
  }

	static WorkoutEntity fromDocument(Map<String, dynamic> doc) {
    return WorkoutEntity(
      name: doc['name'] as String,
      category: doc['category'] as String,
      gifUrl: doc['gifUrl'] as String,
    );
  }
	
	@override
	List<Object?> get props => [
    name,
    category,
    gifUrl,
  ];

	@override
  String toString() {
    return '''UserEntity: {
      name: $name,
      category: $category,
      gifUrl: $gifUrl,
    }''';
  }
}