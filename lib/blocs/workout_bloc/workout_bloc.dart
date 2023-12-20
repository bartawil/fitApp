// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_demo/components/constants.dart';
import 'package:user_repository/user_repository.dart';
import 'package:workout_repository/workout_repository.dart';
part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository _workoutRepository;
  final UserRepository _userRepository;

  /// Constructs a [WorkoutBloc] instance.
  ///
  /// [workoutRepository] is used to interact with workout data.
  /// [userRepository] is used to interact with user-related data.
  WorkoutBloc({
    required WorkoutRepository workoutRepository,
    required UserRepository userRepository
  }) : _workoutRepository = workoutRepository, _userRepository = userRepository,
    super(WorkoutInitial()) {
      // Register event handlers
      on<GetWorkoutGif>((event, emit) async {
        emit(GetWorkoutGifLoading());
        try {
          String gifUrl = await _workoutRepository.getGif();
          emit(GetWorkoutGifSuccess(gifUrl));
        } catch (e) {
          emit(GetWorkoutGifFailure());
        }
      });
      
      on<GetWorkoutsList>((event, emit) async {
        emit(GetWorkoutsListLoading());
        try {
          List<Workout> workoutsList = await _workoutRepository.getWorkoutsList(event.workoutType);
          emit(GetWorkoutsListSuccess(workoutsList));
        } catch (e) {
          emit(GetWorkoutsListFailure());
        }
      });

      on<UpdateUserWorkout>((event, emit) async {
        emit(GetUpdateWorkoutGifLoading());
        try {
          await _userRepository.updateUserWorkoutCollection(
            event.userId, 
            event.workoutId,
            event.category,
            event.workoutNumber,
            event.sets,
            event.reps
          );
          emit(const GetUpdateWorkoutGifSuccess());
        } catch (e) {
          emit(GetUpdateWorkoutGifFailure());
        }
      });

      on<GetUserWorkoutList>((event, emit) async {
        emit(GetUserWorkoutListLoading());
        try {
          List<UserWorkout> weightList = await _userRepository.getWorkoutList(event.userId, event.workoutNumber);
          emit(GetUserWorkoutListSuccess(weightList));
        } catch (e) {
          emit(GetUserWorkoutListFailure());
        }
      });
      
      on<GetWorkoutById>((event, emit) async {
        emit(GetWorkoutByIdLoading());
        try {
          Workout workout = await _workoutRepository.getWorkoutById(event.category, event.workoutId);
          emit(GetWorkoutByIdSuccess(workout));
        } catch (e) {
          emit(GetWorkoutByIdFailure());
        }
      });
    }
}
