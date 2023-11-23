import '../workout_repository.dart';

abstract class WorkoutRepository {

  Future<String> getGif();
}