// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class Workout extends Equatable {
  final String id;
	final String name;
  final String category;
  final String gifUrl;

	Workout({
    required this.id,
		required this.name,
    required this.category,
    required this.gifUrl,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = Workout(
    id: '',
    name: '',
    category: '',
    gifUrl: '',
	);

	/// Modify Workout parameters
	Workout copyWith({
    String? id,
    String? name,
    String? category,
    String? gifUrl,
  }) {
    return Workout(
      id: id ?? this.id,
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
      id: id,
      name: name,
      category: category,
      gifUrl: gifUrl,
    );
  }

	static Workout fromEntity(WorkoutEntity entity) {
    return Workout(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      gifUrl: entity.gifUrl,
    );
  }


	@override
	List<Object?> get props => [
    id,
    name,
    category,
    gifUrl,
  ];
	
}