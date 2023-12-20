part of 'weight_bloc.dart';

sealed class WeightState extends Equatable {
  const WeightState();
  
  @override
  List<Object> get props => [];
}

final class WeightInitial extends WeightState {}

// Define a state class for getting the list of user weight data
final class GetWeightFailure extends WeightState {}
final class GetWeightLoading extends WeightState {}
final class GetWeightSuccess extends WeightState {
	final List<Weight> weightList;

	const GetWeightSuccess(this.weightList);
}


// Define a state class for deleting a specific weight entry
final class DeleteWeightFailure extends WeightState {}
final class DeleteWeightLoading extends WeightState {}
final class DeleteWeightSuccess extends WeightState {
  final List<Weight> weightList;

  const DeleteWeightSuccess(this.weightList);
}


// Define a state class for setting user weight data
final class SetWeightFailure extends WeightState {}
final class SetWeightLoading extends WeightState {}
final class SetWeightSuccess extends WeightState {
  final List<Weight> weightList;

  const SetWeightSuccess(this.weightList);
}