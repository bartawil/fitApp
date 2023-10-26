part of 'weight_bloc.dart';

sealed class WeightEvent extends Equatable {
  const WeightEvent();

  @override
  List<Object> get props => [];
}

class GetWeightList extends WeightEvent{
  final String userId;

  const GetWeightList(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteWeight extends WeightEvent{
  final String userId;
  final String weightId;

  const DeleteWeight(this.userId, this.weightId);

  @override
  List<Object> get props => [userId, weightId];
}

class SetWeight extends WeightEvent{
  final String userId;
  final Weight weight;

  const SetWeight(this.userId, this.weight);

  @override
  List<Object> get props => [userId, weight];
}
