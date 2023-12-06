part of 'workout_bloc.dart';

sealed class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class GetWorkoutGif extends WorkoutEvent{
  const GetWorkoutGif();

  @override
  List<Object> get props => [];
}

class GetWorkoutsList extends WorkoutEvent{
  final String workoutType;

  const GetWorkoutsList(this.workoutType);

  @override
  List<Object> get props => [workoutTypes];
}

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
