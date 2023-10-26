// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'weight_event.dart';
part 'weight_state.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  // ignore: prefer_final_fields
  UserRepository _userRepository;

  WeightBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
		super(WeightInitial()) {
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
    on<SetWeight>((event, emit) async {
      emit(SetWeightLoading());
      try {
        await _userRepository.setWeightData(event.userId, event.weight);
        List<Weight> weightList = await _userRepository.getWeightList(event.userId);
        emit(SetWeightSuccess(weightList));
      } catch (e) {
        emit(SetWeightFailure());
      }
    });
  }
}
