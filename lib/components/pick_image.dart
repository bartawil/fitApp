// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickAndCropImage(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 500,
    maxWidth: 500,
    imageQuality: 40,
  );
  if (image != null) {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Theme.of(context).colorScheme.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      context.read<UpdateUserInfoBloc>().add(
            UploadPicture(
              croppedFile.path,
              context.read<MyUserBloc>().state.user!.id,
            ),
          );
    }
  }
  image = null;
}
