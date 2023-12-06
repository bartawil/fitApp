import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/user_workout_entity.dart';

// ignore: must_be_immutable
class UserWorkout extends Equatable {
  String id;
  String workoutId;
  String category;
  double workoutNumber;
  double sets;
  double reps;

  UserWorkout({
    required this.id,
    required this.workoutId,
    required this.category,
    required this.workoutNumber,
    required this.sets,
    required this.reps,
  });

  static final empty = UserWorkout(
    id: '',
    workoutId: '',
    category: '',
    workoutNumber: 0,
    sets: 0,
    reps: 0,
  );

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