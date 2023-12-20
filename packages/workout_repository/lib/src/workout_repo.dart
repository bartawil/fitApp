import '../workout_repository.dart';

/// An abstract class that defines the contract for accessing workout data.
abstract class WorkoutRepository {

  /// Retrieves a GIF URL.
  ///
  /// Returns a [Future] that resolves to a [String] representing the GIF URL.
  Future<String> getGif();


  /// Retrieves a list of workouts based on the specified workout [type].
  ///
  /// workout [type] specifies the type of workouts to retrieve.
  ///
  /// Returns a [Future] that resolves to a [List] of [Workout] objects.
  Future<List<Workout>> getWorkoutsList(String type);


  /// Retrieves a workout by its [category] and [workoutId].
  ///
  /// [category] specifies the category of the workout.
  /// [workoutId] is the unique identifier of the workout.
  ///
  /// Returns a [Future] that resolves to a [Workout] object.
  Future<Workout> getWorkoutById(String category, String workoutId);
}