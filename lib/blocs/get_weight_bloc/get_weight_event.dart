part of 'get_weight_bloc.dart';

sealed class GetWeightEvent extends Equatable {
  const GetWeightEvent();

  @override
  List<Object> get props => [];
}

class GetWeightList extends GetWeightEvent{
  final String userId;

  const GetWeightList(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteWeight extends GetWeightEvent{
  final String userId;
  final String weightId;

  const DeleteWeight(this.userId, this.weightId);

  @override
  List<Object> get props => [userId, weightId];
}
