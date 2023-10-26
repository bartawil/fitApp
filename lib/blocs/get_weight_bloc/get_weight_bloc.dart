// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_weight_event.dart';
part 'get_weight_state.dart';

class GetWeightBloc extends Bloc<GetWeightEvent, GetWeightState> {
  // ignore: prefer_final_fields
  UserRepository _userRepository;

  GetWeightBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
		super(GetWeightInitial()) {
    on<GetWeightList>((event, emit) async {
			emit(GetWeightLoading());
      try {
				List<Weight> weightList = await _userRepository.getWeightList(event.userId);
        emit(GetWeightSuccess(weightList));
      } catch (e) {
        emit(GetWeightFailure());
      }
    });
    on<DeleteWeight>((event, emit) async {
      emit(DeleteWeightLoading());
      try {
        List<Weight> weightList = await _userRepository.deleteWeight(event.userId, event.weightId);
        emit(DeleteWeightSuccess(weightList));
      } catch (e) {
        emit(DeleteWeightFailure());
      }
    });
  }
}
