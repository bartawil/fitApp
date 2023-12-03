// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_demo/components/constants.dart';
import 'package:workout_repository/workout_repository.dart';
part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository _workoutRepository;

  WorkoutBloc({
    required WorkoutRepository workoutRepository
  }) : _workoutRepository = workoutRepository,
    super(WorkoutInitial()) {
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
    }
}
