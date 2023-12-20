import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/user_workout_entity.dart';

/// A class representing user workout information with various attributes.
// ignore: must_be_immutable
class UserWorkout extends Equatable {
  String id;
  String workoutId;
  String category;
  double workoutNumber;
  double sets;
  double reps;

  /// Creates a new instance of [UserWorkout] with the provided values.
  UserWorkout({
    required this.id,
    required this.workoutId,
    required this.category,
    required this.workoutNumber,
    required this.sets,
    required this.reps,
  });

  /// An empty user workout, which represents an uninitialized or empty workout entry.
  static final empty = UserWorkout(
    id: '',
    workoutId: '',
    category: '',
    workoutNumber: 0,
    sets: 0,
    reps: 0,
  );

  /// Modifies the parameters of the current [UserWorkout] instance and returns a new instance.
  UserWorkout copyWith({
    String? id,
    String? workoutId,
    String? category,
    double? workoutNumber,
    double? sets,
    double? reps,
  }) {
    return UserWorkout(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      category: category ?? this.category,
      workoutNumber: workoutNumber ?? this.workoutNumber,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
    );
  }

  bool get isEmpty => this == UserWorkout.empty;

  bool get isNotEmpty => this != UserWorkout.empty;

  /// Converts the [UserWorkout] instance to a [UserWorkoutEntity].
  UserWorkoutEntity toEntity() {
    return UserWorkoutEntity(
      id: id,
      workoutId: workoutId,
      category: category,
      workoutNumber: workoutNumber,
      sets: sets,
      reps: reps,
    );
  } 

  /// Creates a [UserWorkout] instance from a [UserWorkoutEntity] instance.
  static UserWorkout fromEntity(UserWorkoutEntity entity) {
    return UserWorkout(
      id: entity.id,
      workoutId: entity.workoutId,
      category: entity.category,
      workoutNumber: entity.workoutNumber,
      sets: entity.sets,
      reps: entity.reps,
    );
  }

  @override
  List<Object> get props => [id, workoutId, category, workoutNumber, sets, reps];
}