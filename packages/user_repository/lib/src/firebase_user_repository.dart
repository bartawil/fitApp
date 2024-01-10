import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';


/// A Flutter repository implementation for managing user authentication and data
/// storage using Firebase services.
///
/// This class implements the [UserRepository] interface and provides methods for
/// user sign-up, sign-in, sign-out, password reset, and managing user data, such as
/// user profile pictures and workout-related data.
class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');


  /// Stream of [MyUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [MyUser.empty] if the user is not authenticated.
  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      return user;
    });
  }


  /// Registers a new user with the provided [myUser] and [password].
  ///
  /// Throws a [CustomFirebaseAuthException] if registration fails.
  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser = myUser.copyWith(id: user.user!.uid);

      createWeightCollection(myUser.weight, myUser.id);

      return myUser;
    } on FirebaseAuthException catch (e) {
      final errorMessage = e.message;
      log(e.toString());
      throw CustomFirebaseAuthException(errorMessage!);
    }
  }


  /// Signs in a user with the provided [email] and [password].
  ///
  /// Throws an exception if sign-in fails.
  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Signs out the currently authenticated user.
  ///
  /// Throws an exception if sign-out fails.
  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Sends a password reset email to the user with the provided [email].
  ///
  /// Throws a [CustomFirebaseAuthException] if the email cannot be sent.
  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final errorMessage = e.message;
      log(e.toString());
      throw CustomFirebaseAuthException(errorMessage!);
    }
  }


  /// Sets user data in Firestore using the provided [user] object.
  ///
  /// Throws an exception if data cannot be set.
  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await usersCollection.doc(user.id).set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Retrieves user data from Firestore using the provided [myUserId].
  ///
  /// Throws an exception if data cannot be retrieved.
  @override
  Future<MyUser> getMyUser(String myUserId) async {
    try {
      return usersCollection.doc(myUserId).get().then((value) =>
          MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Uploads a user profile picture to Firebase Storage and updates the
  /// user's Firestore document with the picture URL.
  ///
  /// Throws an exception if the upload fails.
  @override
  Future<String> uploadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);
      Reference firebaseStoreRef =
          FirebaseStorage.instance.ref().child('$userId/PP/${userId}_lead');
      await firebaseStoreRef.putFile(
        imageFile,
      );
      String url = await firebaseStoreRef.getDownloadURL();
      await usersCollection.doc(userId).update({'picture': url});
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Creates a new weight entry for the user in Firestore.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<void> createWeightCollection(String weightValue, String userId) async {
    try {
      late Weight newWeight;
      newWeight = Weight.empty;
      newWeight.id = const Uuid().v1();

      await usersCollection
          .doc(userId)
          .collection('weights')
          .doc(newWeight.id)
          .set({
        'id': newWeight.id,
        'weight': weightValue,
        'date': DateTime.now(),
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Retrieves a list of weight entries for the user from Firestore.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<List<Weight>> getWeightList(String userId) {
    try {
      return usersCollection.doc(userId).collection('weights').get().then(
          (value) => value.docs
              .map(
                  (e) => Weight.fromEntity(WeightEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Deletes a weight entry for the user from Firestore and returns the updated list.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<List<Weight>> deleteWeight(String userId, String weightId) async {
    try {
      await usersCollection
          .doc(userId)
          .collection('weights')
          .doc(weightId)
          .delete();
      return getWeightList(userId);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Sets weight data for the user in Firestore.
  ///
  /// Throws an exception if data cannot be set.
  @override
  Future<void> setWeightData(String userId, Weight weight) async {
    try {
      await usersCollection
          .doc(userId)
          .collection('weights')
          .doc(weight.id)
          .set(weight.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Retrieves a list of workout entries for the user from Firestore.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<List<UserWorkout>> getWorkoutList(String userId, double workoutNumber) {
    try {
      return usersCollection.doc(userId).collection('workouts ${workoutNumber.toInt()}').get().then(
          (value) => value.docs
              .map(
                  (e) => UserWorkout.fromEntity(UserWorkoutEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Updates or creates a workout entry for the user in Firestore.
  ///
  /// Throws an exception if data cannot be set or updated.
  @override
  Future<void> updateUserWorkoutCollection(String userId, String workoutId,
      String category, double workoutNumber, double sets, double reps) async {
    try {
          // Delete the existing collection
    await usersCollection
        .doc(userId)
        .collection('workouts ${workoutNumber.toInt()}')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

      String id = const Uuid().v1();
      await usersCollection
          .doc(userId)
          .collection('workouts ${workoutNumber.toInt()}')
          .doc(id)
          .set({
        'id': id,
        'workoutId': workoutId,
        'category': category,
        'workoutNumber': workoutNumber,
        'sets': sets,
        'reps': reps,
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  /// Creates a new measurements entry for the user in Firestore.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<void> createMeasurementsCollection(Measurements measurement, String userId) async {
    try {
      String newId = const Uuid().v1();
      measurement = measurement.copyWith(id: newId);

      await usersCollection
          .doc(userId)
          .collection('measurements')
          .doc(measurement.id)
          .set({
            'id': measurement.id,
            'date': DateTime.now(),
            'weight': measurement.weight,
            'bodyFat': measurement.bodyFat,
            'neckCircumference': measurement.neckCircumference,
            'armCircumference': measurement.armCircumference,
            'waistCircumference': measurement.waistCircumference,
            'hipCircumference': measurement.hipCircumference,
            'thighCircumference': measurement.thighCircumference,
            'backHand': measurement.backHand,
            'abdomen': measurement.abdomen,
            'lowerBack': measurement.lowerBack,
            'leg': measurement.leg,
          });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Retrieves a list of measurements entries for the user from Firestore.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<List<Measurements>> getMeasurementsList(String userId) {
    try {
      return usersCollection.doc(userId).collection('measurements').get().then(
          (value) => value.docs
              .map(
                  (e) => Measurements.fromEntity(MeasurementsEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Sets user measurements record in Firestore using the provided [measurments] object.
  ///
  /// Throws an exception if data cannot be set.
  @override
  Future<List<Measurements>> setMeasurements(String userId, Measurements record) async {
    try {
      await usersCollection
        .doc(userId)
        .collection('measurements')
        .doc(record.id)
        .set(record.toEntity().toDocument());
      
      return getMeasurementsList(userId);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// Deletes a measurements entry for the user from Firestore and returns the updated list.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<List<Measurements>> deleteMeasurements(String userId, String recordId) async {
    try {
      await usersCollection
          .doc(userId)
          .collection('measurements')
          .doc(recordId)
          .delete();
      return getMeasurementsList(userId);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}


/// Custom exception class for Firebase authentication errors.
class CustomFirebaseAuthException implements Exception {
  final String message;

  CustomFirebaseAuthException(this.message);
}
