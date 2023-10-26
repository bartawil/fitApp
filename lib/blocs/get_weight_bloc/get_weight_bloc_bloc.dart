// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_weight_bloc_event.dart';
part 'get_weight_bloc_state.dart';

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
				List<Weight> posts = await _userRepository.getWeightList(event.userId);
        emit(GetWeightSuccess(posts));
      } catch (e) {
        emit(GetWeightFailure());
      }
    });
  }
}
