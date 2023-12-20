// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

/// Represents a workout with associated information.
class Workout extends Equatable {
  final String id;
	final String name;
  final String category;
  final String gifUrl;

  /// Constructs a [Workout] object.
  ///
  /// [id] is the unique identifier of the workout.
  /// [name] is the name of the workout.
  /// [category] is the category or type of the workout.
  /// [gifUrl] is the URL of the GIF associated with the workout.
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

	/// Creates a new [Workout] object with updated properties.
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

  /// Converts the [Workout] object to a corresponding [WorkoutEntity].
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