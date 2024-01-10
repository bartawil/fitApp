part of 'measurements_bloc.dart';

sealed class MeasurementsEvent extends Equatable {
  const MeasurementsEvent();

  @override
  List<Object> get props => [];
}


// Define an event class for setting user measurements data
class AddMeasurements extends MeasurementsEvent{
  final String userId;
  final Measurements measurement;

  const AddMeasurements({required this.userId, required this.measurement});

  @override
  List<Object> get props => [userId, measurement];
}

// get user measurements data
class GetMeasurementsList extends MeasurementsEvent{
  final String userId;

  const GetMeasurementsList({required this.userId});

  @override
  List<Object> get props => [userId];
}

// Define an event class for updating user measurements data
class UpdateMeasurements extends MeasurementsEvent{
  final String userId;
  final Measurements record;

  const UpdateMeasurements({required this.userId, required this.record});

  @override
  List<Object> get props => [userId, record];
}

// Define an event class for deleting user measurements data
class DeleteMeasurements extends MeasurementsEvent{
  final String userId;
  final String recordId;

  const DeleteMeasurements({required this.userId, required this.recordId});

  @override
  List<Object> get props => [userId, recordId];
}
