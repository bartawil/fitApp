import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

  Future<void> uploadData() async {
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
    }
    await batch.commit();
  }
}