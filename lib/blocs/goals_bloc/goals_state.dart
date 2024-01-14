part of 'goals_bloc.dart';

sealed class GoalsState extends Equatable {
  const GoalsState();
  
  @override
  List<Object> get props => [];
}

final class GoalsInitial extends GoalsState {}

// get user goals data
final class GetGoalsFailure extends GoalsState {}
final class GetGoalsLoading extends GoalsState {}
final class GetGoalsSuccess extends GoalsState {
  final Goals goals;

  const GetGoalsSuccess({required this.goals});

  @override
  List<Object> get props => [goals];
}

// Define a state class for updating user goals data
final class UpdateGoalsFailure extends GoalsState {}
final class UpdateGoalsLoading extends GoalsState {}
final class UpdateGoalsSuccess extends GoalsState {
  final Goals goals;

  const UpdateGoalsSuccess({required this.goals});

  @override
  List<Object> get props => [goals];
}