import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// Get from camera
Future<String?> getFromCamera() async {
  ImagePicker imagePicker = ImagePicker();

  XFile? image = await imagePicker.pickImage(source: ImageSource.camera);

  if (image != null) {
    return await _cropImage(filePath: image.path);
  }
  return null;
}

/// Get from gallery
Future<String?> getFromGallery() async {
  ImagePicker imagePicker = ImagePicker();

  XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    return await _cropImage(filePath: image.path);
  }
  return null;
}

/// Crop Image
Future<String?> _cropImage({required filePath}) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    maxWidth: 1280,
    aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
    uiSettings: [
      AndroidUiSettings(toolbarTitle: 'Pangkas Foto'),
      IOSUiSettings(title: 'Pangkas Foto'),
    ],
  );

  return croppedImage?.path;
}
