import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/controllers/question_papers/data_uploader.dart';
import 'package:flutter_demo/firebase_re/loading_status.dart';
import 'package:get/get.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({super.key});
  DataUploader controlles = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Obx(()=>Text(controlles.loadingStatus.value==LoadingStatus.completed? "Uploading completed":
      "Uploading...")),
    ));
  }
}