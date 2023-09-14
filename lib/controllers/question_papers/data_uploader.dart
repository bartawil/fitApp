import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/firebase_re/loading_status.dart';
import 'package:flutter_demo/firebase_re/references.dart';
import 'package:flutter_demo/models/quesion_paper_model.dart';
import 'package:get/get.dart';
import 'dart:convert';

// upload data to firebase database
class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }
  final loadingStatus = LoadingStatus.loading.obs; // loadingSatuts is obs


  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; // 0

    final fireStore = FirebaseFirestore.instance;
    // loading the assests from the assests folder
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    // decode them
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // load json files and print path
    final papersInAssets = manifestMap.keys
        .where((path) => 
            path.startsWith("assets/DB/papers") && path.contains(".json"))
        .toList();
    List<QuestionPaperModel> quesionPapers = [];
    // print the content of the json files
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      quesionPapers.add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
    }
    // print('Items number ${quesionPapers[0].description}');
    var batch = fireStore.batch();
    for (var paper in quesionPapers) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "description": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count": paper.questions==null?0:paper.questions!.length
      });

      for (var questions in paper.questions!) {
        final questionPath = questionRF(paperId: paper.id!, questionId: questions.id!);
        batch.set(questionPath, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var answer in questions.answers!) {
          batch.set(
            questionPath.collection("answers").doc(answer.identifier), {
              "identifier": answer.identifier,
              "answer": answer.answer,
            });
        }
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}