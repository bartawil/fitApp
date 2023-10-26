part of 'get_weight_bloc_bloc.dart';

sealed class GetWeightState extends Equatable {
  const GetWeightState();
  
  @override
  List<Object> get props => [];
}

final class GetWeightInitial extends GetWeightState {}

final class GetWeightFailure extends GetWeightState {}
final class GetWeightLoading extends GetWeightState {}
final class GetWeightSuccess extends GetWeightState {
	final List<Weight> weightList;

	const GetWeightSuccess(this.weightList);
}