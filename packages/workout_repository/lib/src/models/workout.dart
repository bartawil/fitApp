// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class Workout extends Equatable {
	final String name;
  final String category;
  final String gifUrl;

	Workout({
		required this.name,
    required this.category,
    required this.gifUrl,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = Workout(
    name: '',
    category: '',
    gifUrl: '',
	);

	/// Modify Workout parameters
	Workout copyWith({
    String? name,
    String? category,
    String? gifUrl,
  }) {
    return Workout(
      name: name ?? this.name,
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
      name: name,
      category: category,
      gifUrl: gifUrl,
    );
  }

	static Workout fromEntity(WorkoutEntity entity) {
    return Workout(
      name: entity.name,
      category: entity.category,
      gifUrl: entity.gifUrl,
    );
  }


	@override
	List<Object?> get props => [
    name,
    category,
    gifUrl,
  ];
	
}