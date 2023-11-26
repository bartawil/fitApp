import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:workout_repository/workout_repository.dart';

class FirebaseWorkoutRepository implements WorkoutRepository {
  final workoutsCollection = FirebaseFirestore.instance.collection('workouts');

  @override
  Future<String> getGif() async {
    try {
      Reference firebaseStoreRef = FirebaseStorage.instance
          .ref()
          .child('workout/Legs/barbell-rack-pull.gif');
      String url = await firebaseStoreRef.getDownloadURL();

      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // helper function to upload all gifs to firestore collection
  Future<void> uploadAllGifs() async {
    try {
      Reference firebaseStoreRef1 =
          FirebaseStorage.instance.ref().child('workout');
      ListResult result1 = await firebaseStoreRef1.listAll();

      List<String> subfolderNames = [];

      for (Reference ref in result1.prefixes) {
        String subfolderName = ref.name;
        subfolderNames.add(subfolderName);
      }

      print(subfolderNames);

      for (String folder in subfolderNames) {
        Reference firebaseStoreRef =
            FirebaseStorage.instance.ref().child('workout/$folder');
        ListResult result = await firebaseStoreRef.listAll();

        List<String> gifUrls = [];

        for (Reference ref in result.items) {
          String url = await ref.getDownloadURL();
          String workoutName = ref.name
              .toLowerCase()
              .replaceAll('-', ' ')
              .replaceAll('_', ' ')
              .replaceAll('.gif', '');
          String category = folder;

          Workout newWorkout = Workout(
            workoutName: workoutName,
            category: category,
            gifUrl: url,
          );

          await workoutsCollection.doc(newWorkout.workoutName).set({
            'name': newWorkout.workoutName,
            'category': newWorkout.category,
            'gifUrl': newWorkout.gifUrl,
          });
          gifUrls.add(url);
        }
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
