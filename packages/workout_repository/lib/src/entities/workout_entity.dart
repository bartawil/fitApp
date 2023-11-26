// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class WorkoutEntity extends Equatable {
	String workoutName;
  String category;
  String? gifUrl;


	WorkoutEntity({
		required this.workoutName,
    required this.category,
    this.gifUrl,
	});

	Map<String, Object?> toDocument() {
    return {
      'workoutName': workoutName,
      'category': category,
      'gifUrl': gifUrl,
    };
  }

	static WorkoutEntity fromDocument(Map<String, dynamic> doc) {
    return WorkoutEntity(
      workoutName: doc['workoutName'] as String,
      category: doc['category'] as String,
      gifUrl: doc['gifUrl'] as String?,
    );
  }
	
	@override
	List<Object?> get props => [
    workoutName,
    category,
    gifUrl,
  ];

	@override
  String toString() {
    return '''UserEntity: {
      workoutName: $workoutName,
      category: $category,
      gifUrl: $gifUrl,
    }''';
  }
}