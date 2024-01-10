import 'package:firebase_auth/firebase_auth.dart';
import '../user_repository.dart';

/// An abstract class representing a user repository for managing user authentication
/// and data storage in a Flutter application.
abstract class UserRepository {
  /// A stream that emits the currently authenticated user when the authentication
  /// state changes. Emits [null] if the user is not authenticated.
  Stream<User?> get user;

  /// Signs in a user with the provided [email] and [password].
  Future<void> signIn(String email, String password);

  /// Signs out the currently authenticated user.
  Future<void> logOut();

  /// Registers a new user with the provided [myUser] and [password].
  Future<MyUser> signUp(MyUser myUser, String password);

  /// Sends a password reset email to the user with the provided [email].
  Future<void> resetPassword(String email);

  /// Sets user data in the data storage.
  Future<void> setUserData(MyUser user);

  /// Retrieves user data from the data storage using the provided [myUserId].
  Future<MyUser> getMyUser(String myUserId);

  /// Uploads a file (e.g., user profile picture) associated with a user
  /// and returns the uploaded file's URL.
  Future<String> uploadPicture(String file, String userId);

  /// Creates a new collection of weight data for a user in the data storage.
  Future<void> createWeightCollection(String weight, String userId);

  /// Retrieves a list of weight entries for a user from the data storage.
  Future<List<Weight>> getWeightList(String userId);

  /// Deletes a weight entry for a user from the data storage and returns the updated list.
  Future<List<Weight>> deleteWeight(String userId, String weightId);

  /// Sets workout data for a user in the data storage.
  Future<void> setWeightData(String userId, Weight weight);

  /// Updates or creates a workout entry for a user in the data storage.
  Future<void> updateUserWorkoutCollection(
    String userId,
    String workoutId,
    String category,
    double workoutNumber,
    double sets,
    double reps,
  );

  /// Retrieves a list of workout entries for a user from the data storage.
  Future<List<UserWorkout>> getWorkoutList(String userId, double workoutNumber);

  // Creates a new measurements entry for the user in Firestore.
  Future<void> createMeasurementsCollection(Measurements measurement, String userId);

  /// Retrieves a list of measurements entries for the user from Firestore.
  Future<List<Measurements>> getMeasurementsList(String userId);

  // Update measurements entry for the user in Firestore.
  Future<List<Measurements>> setMeasurements(String userId, Measurements record);

  // Deletes measurements entry for the user in Firestore.
  Future<List<Measurements>> deleteMeasurements(String userId, String recordId);
}
