import 'package:equatable/equatable.dart';

/// A class representing user workout information in a Firestore document.
class UserWorkoutEntity extends Equatable {
  final String id;
  final String workoutId;
  final String category;
  final double workoutNumber;
  final double sets;
  final double reps;

  /// Creates a new instance of [UserWorkoutEntity] with the provided values.
  const UserWorkoutEntity({
    required this.id,
    required this.workoutId,
    required this.category,
    required this.workoutNumber,
    required this.sets,
    required this.reps,
  });

  /// Converts the [UserWorkoutEntity] instance to a Firestore document as a map.
  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'workoutId': workoutId,
      'category': category,
      'workoutNumber': workoutNumber,
      'sets': sets,
      'reps': reps,
    };
  }

  /// Creates a [UserWorkoutEntity] instance from a Firestore document map.
  static UserWorkoutEntity fromDocument(Map<String, dynamic> doc) {
    return UserWorkoutEntity(
      id: doc['id'] as String,
      workoutId: doc['workoutId'] as String,
      category: doc['category'] as String,
      workoutNumber: doc['workoutNumber'] as double,
      sets: doc['sets'] as double,
      reps: doc['reps'] as double,
    );
  }

  @override
  List<Object> get props => [id, workoutId, category, workoutNumber, sets, reps];

  @override
  String toString() {
    return '''UserWorkoutEntity { 
      id: $id,
      workoutId: $workoutId, 
      category: $category,
      workoutNumber: $workoutNumber,
      sets: $sets,
      reps: $reps,
    }''';
  }
}