// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class Workout extends Equatable {
	final String workoutName;
  final String category;
  String? gifUrl;

	Workout({
		required this.workoutName,
    required this.category,
    this.gifUrl,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = Workout(
    workoutName: '',
    category: '',
    gifUrl: '',
	);

	/// Modify Workout parameters
	Workout copyWith({
    String? workoutName,
    String? category,
    String? gifUrl,
  }) {
    return Workout(
      workoutName: workoutName ?? this.workoutName,
      category: category ?? this.category,
      gifUrl: gifUrl ?? this.gifUrl,
    );
  }

	/// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Workout.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Workout.empty;

	WorkoutEntity toEntity() {
    return WorkoutEntity(
      workoutName: workoutName,
      category: category,
      gifUrl: gifUrl,
    );
  }

	static Workout fromEntity(WorkoutEntity entity) {
    return Workout(
      workoutName: entity.workoutName,
      category: entity.category,
      gifUrl: entity.gifUrl,
    );
  }


	@override
	List<Object?> get props => [
    workoutName,
    category,
    gifUrl,
  ];
	
}