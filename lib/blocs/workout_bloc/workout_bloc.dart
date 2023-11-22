import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  UserRepository _userRepository;

  WorkoutBloc({
    required UserRepository userRepository
  }) : _userRepository = userRepository,
    super(WorkoutInitial()) {
      on<GetWorkoutGif>((event, emit) async {
        emit(GetWorkoutGifLoading());
        try {
          String gifUrl = await _userRepository.getGif();
          emit(GetWorkoutGifSuccess(gifUrl));
        } catch (e) {
          emit(GetWorkoutGifFailure());
        }
      });
    }
}
