part of 'weight_bloc.dart';

sealed class WeightEvent extends Equatable {
  const WeightEvent();

  @override
  List<Object> get props => [];
}

// Define an event class for getting the list of user weight data
class GetWeightList extends WeightEvent{
  final String userId;

  const GetWeightList(this.userId);

  @override
  List<Object> get props => [userId];
}


// Define an event class for deleting a specific weight entry
class DeleteWeight extends WeightEvent{
  final String userId;
  final String weightId;
  final String prvWeight;

  const DeleteWeight(this.userId, this.weightId, this.prvWeight);

  @override
  List<Object> get props => [userId, weightId, prvWeight];
}


// Define an event class for setting user weight data
class SetWeight extends WeightEvent{
  final String userId;
  final Weight weight;

  const SetWeight(this.userId, this.weight);

  @override
  List<Object> get props => [userId, weight];
}
