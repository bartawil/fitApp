import '../workout_repository.dart';

abstract class WorkoutRepository {

  Future<String> getGif();

  Future<List<Workout>> getWorkoutsList(String type);
}