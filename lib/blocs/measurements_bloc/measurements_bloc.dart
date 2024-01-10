// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'measurements_event.dart';
part 'measurements_state.dart';

class MeasurementsBloc extends Bloc<MeasurementsEvent, MeasurementsState> {
  // ignore: prefer_final_fields
  UserRepository _userRepository;

  MeasurementsBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(MeasurementsInitial()) {
    // update client meeting measurements in firestore
    on<AddMeasurements>((event, emit) async {
      emit(AddMeasurementsLoading());
      try {
        // Set user measurements data using the repository
        await _userRepository.createMeasurementsCollection(
            event.measurement, event.userId);
        emit(AddMeasurementsSuccess());
      } catch (e) {
        emit(AddMeasurementsFailure());
      }
    });

    // get client meeting measurements List from firestore
    on<GetMeasurementsList>((event, emit) async {
      emit(GetMeasurementsListLoading());
      try {
        // Get user measurements data using the repository
        List<Measurements> measurementsList =
            await _userRepository.getMeasurementsList(event.userId);
        emit(GetMeasurementsListSuccess(measurementsList: measurementsList));
      } catch (e) {
        emit(GetMeasurementsListFailure());
      }
    });

    // update client meeting measurements in firestore
    on<UpdateMeasurements>((event, emit) async {
      emit(UpdateMeasurementsLoading());
      try {
        // Set user measurements data using the repository
        List<Measurements> measurementsList =
            await _userRepository.setMeasurements(event.userId, event.record);
        emit(UpdateMeasurementsSuccess(measurementsList: measurementsList));
      } catch (e) {
        emit(UpdateMeasurementsFailure());
      }
    });

    // delete client meeting measurements in firestore
    on<DeleteMeasurements>((event, emit) async {
      emit(DeleteMeasurementsLoading());
      try {
        // delete user measurements record using the repository
        List<Measurements> measurementsList =
            await _userRepository.deleteMeasurements(event.userId, event.recordId);
        emit(DeleteMeasurementsSuccess(measurementsList: measurementsList));
      } catch (e) {
        emit(DeleteMeasurementsFailure());
      }
    });
  }
}
