import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:workout_repository/workout_repository.dart';

class FirebaseWorkoutRepository implements WorkoutRepository {

  @override
  Future<String> getGif() async {
    try {
      Reference firebaseStoreRef =
          FirebaseStorage.instance.ref().child('workout/Legs/Air-Squat.gif');
      String url = await firebaseStoreRef.getDownloadURL();
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
  
