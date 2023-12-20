// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


/// A utility function for picking and cropping an image for user profile updates.
/// 
/// This function allows the user to select an image from the device's gallery,
/// crop it to a square aspect ratio, and then upload it for updating their profile picture.
/// 
Future<void> pickAndCropImage(BuildContext context) async {
  // Create an instance of the ImagePicker to select an image from the gallery.
  final ImagePicker picker = ImagePicker();

  // Attempt to pick an image with specific configurations.
  XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 500,
    maxWidth: 500,
    imageQuality: 40,
  );

  // If an image is selected, proceed with cropping.
  if (image != null) {
    // Crop the selected image to a square aspect ratio.
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
    // If the image is successfully cropped, upload it to update the user's profile picture.
    if (croppedFile != null) {
      context.read<UpdateUserInfoBloc>().add(
            UploadPicture(
              croppedFile.path,
              context.read<MyUserBloc>().state.user!.id,
            ),
          );
    }
  }
  // Reset the image variable to null to release resources.
  image = null;
}
