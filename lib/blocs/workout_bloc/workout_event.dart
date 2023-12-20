part of 'workout_bloc.dart';

sealed class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

/// Event to request a workout GIF.
class GetWorkoutGif extends WorkoutEvent{
  const GetWorkoutGif();

  @override
  List<Object> get props => [];
}

/// Event to request a list of workouts of a specific type.
class GetWorkoutsList extends WorkoutEvent{
  final String workoutType;

  const GetWorkoutsList(this.workoutType);

  @override
  List<Object> get props => [workoutTypes];
}

/// Event to update a user's workout information.
class UpdateUserWorkout extends WorkoutEvent{
  final String userId;
  final String workoutId;
  final String category;
  final double workoutNumber;
  final double sets;
  final double reps;

  const UpdateUserWorkout(
    this.userId, 
    this.workoutId,
    this.category,
    this.workoutNumber,
    this.sets,
    this.reps
  );

  @override
  List<Object> get props => [];
}


/// Event to request a list of a user's workouts.
class GetUserWorkoutList extends WorkoutEvent{
  final String userId;
  final double workoutNumber;

  const GetUserWorkoutList(this.userId, this.workoutNumber);

  @override
  List<Object> get props => [];
}


/// Event to request a specific workout by its category and ID.
class GetWorkoutById extends WorkoutEvent{
  final String category;
  final String workoutId;

  const GetWorkoutById(this.category, this.workoutId);

  @override
  List<Object> get props => [];
}
