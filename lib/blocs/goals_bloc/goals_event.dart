part of 'goals_bloc.dart';

sealed class GoalsEvent extends Equatable {
  const GoalsEvent();

  @override
  List<Object> get props => [];
}

// get user goals data
class GetGoals extends GoalsEvent{
  final String userId;

  const GetGoals({required this.userId});

  @override
  List<Object> get props => [userId];
}

// Define an event class for updating user goals data
class UpdateGoals extends GoalsEvent{
  final String userId;
  final Goals goals;

  const UpdateGoals({required this.userId, required this.goals});

  @override
  List<Object> get props => [userId, goals];
}
