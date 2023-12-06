import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

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

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

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

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await usersCollection.doc(user.id).set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

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

  @override
  Future<void> updateUserWorkoutCollection(String userId, String workoutId,
      String category, double workoutNumber, double sets, double reps) async {
    try {
      // late UserWorkout newWorkout;
      // newWorkout = userWorkout.copyWith(
      //   id: const Uuid().v1(),
      // );
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
}

class CustomFirebaseAuthException implements Exception {
  final String message;

  CustomFirebaseAuthException(this.message);
}
