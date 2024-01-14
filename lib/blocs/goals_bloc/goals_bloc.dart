// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'goals_event.dart';
part 'goals_state.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  // ignore: prefer_final_fields
  UserRepository _userRepository;

  GoalsBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(GoalsInitial()) {

    // get client meeting goals from firestore
    on<GetGoals>((event, emit) async {
      emit(GetGoalsLoading());
      try {
        // Get user goals data using the repository
        Goals goals =  await _userRepository.getGoals(event.userId);
        emit(GetGoalsSuccess(goals: goals));
      } catch (e) {
        emit(GetGoalsFailure());
      }
    });

    // update client meeting goals in firestore
    on<UpdateGoals>((event, emit) async {
      emit(UpdateGoalsLoading());
      try {
        // Set user goals data using the repository
        Goals goals =
            await _userRepository.setGoals(event.userId, event.goals);
        emit(UpdateGoalsSuccess(goals: goals));
      } catch (e) {
        emit(UpdateGoalsFailure());
      }
    });
  }
}
