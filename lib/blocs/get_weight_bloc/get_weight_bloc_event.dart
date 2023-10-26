part of 'get_weight_bloc_bloc.dart';

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