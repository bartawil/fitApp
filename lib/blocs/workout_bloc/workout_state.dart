part of 'workout_bloc.dart';

sealed class WorkoutState extends Equatable {
  const WorkoutState();
  
  @override
  List<Object> get props => [];
}

final class WorkoutInitial extends WorkoutState {}

final class GetWorkoutGifFailure extends WorkoutState {}
final class GetWorkoutGifLoading extends WorkoutState {}
final class GetWorkoutGifSuccess extends WorkoutState {
  final String gifUrl;

  const GetWorkoutGifSuccess(this.gifUrl);
}

final class GetWorkoutsListFailure extends WorkoutState {}
final class GetWorkoutsListLoading extends WorkoutState {}
final class GetWorkoutsListSuccess extends WorkoutState {
  final List<Workout> workoutsList;

  const GetWorkoutsListSuccess(this.workoutsList);
}