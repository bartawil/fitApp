// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';


/// Represents a workout entity with its properties.
class WorkoutEntity extends Equatable {
  String id;
	String name;
  String category;
  String gifUrl;

  /// Constructs a [WorkoutEntity] object.
	WorkoutEntity({
    required this.id,
		required this.name,
    required this.category,
    required this.gifUrl,
	});

  /// Converts the [WorkoutEntity] object to a [Map] for Firestore storage.
	Map<String, Object?> toDocument() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'gifUrl': gifUrl,
    };
  }

  /// Creates a [WorkoutEntity] object from a Firestore document [Map].
	static WorkoutEntity fromDocument(Map<String, dynamic> doc) {
    return WorkoutEntity(
      id: doc['id'] as String,
      name: doc['name'] as String,
      category: doc['category'] as String,
      gifUrl: doc['gifUrl'] as String,
    );
  }
	
	@override
	List<Object?> get props => [
    id,
    name,
    category,
    gifUrl,
  ];

	@override
  String toString() {
    return '''UserEntity: {
      id: $id,
      name: $name,
      category: $category,
      gifUrl: $gifUrl,
    }''';
  }
}