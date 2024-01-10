part of 'measurements_bloc.dart';

sealed class MeasurementsState extends Equatable {
  const MeasurementsState();
  
  @override
  List<Object> get props => [];
}

final class MeasurementsInitial extends MeasurementsState {}

// Define a state class for setting user weight data
final class AddMeasurementsFailure extends MeasurementsState {}
final class AddMeasurementsLoading extends MeasurementsState {}
final class AddMeasurementsSuccess extends MeasurementsState {}

// get user measurements data
final class GetMeasurementsListFailure extends MeasurementsState {}
final class GetMeasurementsListLoading extends MeasurementsState {}
final class GetMeasurementsListSuccess extends MeasurementsState {
  final List<Measurements> measurementsList;

  const GetMeasurementsListSuccess({required this.measurementsList});

  @override
  List<Object> get props => [measurementsList];
}

// Define a state class for updating user measurements data
final class UpdateMeasurementsFailure extends MeasurementsState {}
final class UpdateMeasurementsLoading extends MeasurementsState {}
final class UpdateMeasurementsSuccess extends MeasurementsState {
  final List<Measurements> measurementsList;

  const UpdateMeasurementsSuccess({required this.measurementsList});

  @override
  List<Object> get props => [measurementsList];
}

// Define a state class for deleting user measurements data
final class DeleteMeasurementsFailure extends MeasurementsState {}
final class DeleteMeasurementsLoading extends MeasurementsState {}
final class DeleteMeasurementsSuccess extends MeasurementsState {
  final List<Measurements> measurementsList;

  const DeleteMeasurementsSuccess({required this.measurementsList});

  @override
  List<Object> get props => [measurementsList];
}