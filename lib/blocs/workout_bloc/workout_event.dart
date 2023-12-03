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
