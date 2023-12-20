part of 'workout_bloc.dart';

sealed class WorkoutState extends Equatable {
  const WorkoutState();
  
  @override
  List<Object> get props => [];
}

final class WorkoutInitial extends WorkoutState {}
 
final class GetWorkoutGifFailure extends WorkoutState {}
final class GetWorkoutGifLoading extends WorkoutState {}
/// State indicating a successful retrieval of the workout GIF.
final class GetWorkoutGifSuccess extends WorkoutState {
  final String gifUrl;

  const GetWorkoutGifSuccess(this.gifUrl);
}

final class GetWorkoutsListFailure extends WorkoutState {}
final class GetWorkoutsListLoading extends WorkoutState {}
/// State indicating a successful retrieval of the list of workouts.
final class GetWorkoutsListSuccess extends WorkoutState {
  final List<Workout> workoutsList;

  const GetWorkoutsListSuccess(this.workoutsList);
}

final class GetUpdateWorkoutGifFailure extends WorkoutState {}
final class GetUpdateWorkoutGifLoading extends WorkoutState {}
/// State indicating a successful update of the user's workout information.
final class GetUpdateWorkoutGifSuccess extends WorkoutState {

  const GetUpdateWorkoutGifSuccess();

  @override
  List<Object> get props => [];
}

final class GetUserWorkoutListFailure extends WorkoutState {}
final class GetUserWorkoutListLoading extends WorkoutState {}
/// State indicating a successful retrieval of the user's workout list.
final class GetUserWorkoutListSuccess extends WorkoutState {
  final List<UserWorkout> userWorkoutList;

  const GetUserWorkoutListSuccess(this.userWorkoutList);
}

final class GetWorkoutByIdFailure extends WorkoutState {}
final class GetWorkoutByIdLoading extends WorkoutState {}
/// State indicating a successful retrieval of a specific workout by ID.
final class GetWorkoutByIdSuccess extends WorkoutState {
  final Workout workout;

  const GetWorkoutByIdSuccess(this.workout);
}