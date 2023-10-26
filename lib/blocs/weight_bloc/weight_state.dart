part of 'weight_bloc.dart';

sealed class WeightState extends Equatable {
  const WeightState();
  
  @override
  List<Object> get props => [];
}

final class WeightInitial extends WeightState {}

final class GetWeightFailure extends WeightState {}
final class GetWeightLoading extends WeightState {}
final class GetWeightSuccess extends WeightState {
	final List<Weight> weightList;

	const GetWeightSuccess(this.weightList);
}

final class DeleteWeightFailure extends WeightState {}
final class DeleteWeightLoading extends WeightState {}
final class DeleteWeightSuccess extends WeightState {
  final List<Weight> weightList;

  const DeleteWeightSuccess(this.weightList);
}