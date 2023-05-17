import 'dart:io';

import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/services/local_storage_service.dart';
import 'package:celenganku/utils/extension/date_time_extension/date_time_extension.dart';
import 'package:path_provider/path_provider.dart';

class WishService {
  static List<WishModel> getOnGoingWishList() {
    return box.values.toList().where((e) => e.completedAt == null).toList()
      ..sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
  }

  static List<WishModel> getAchievedWishList() {
    return box.values.toList().where((e) => e.completedAt != null).toList()
      ..sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
  }

  static Future<void> saveWish(WishModel wish) async {
    WishModel newWish =
        wish.copyWith(imagePath: await _moveImageFile(wish: wish));
    await LocalStorageApi.saveWish(newWish);
  }

  static Future<String?> _moveImageFile({required WishModel wish}) async {
    String? oldImagePath = wish.imagePath;

    // move the cropped image file from cache to app directory
    if (oldImagePath != null) {
      Directory dir = await getApplicationDocumentsDirectory();

      String newDirPath = '${dir.path}/images/';

      Directory(newDirPath).createSync(recursive: true);

      String newFileName =
          '${wish.name.replaceAll(' ', '-')}_${wish.createdAt.toUrl()}.jpg';

      String newFilePath = '$newDirPath$newFileName';

      File newFile = File(oldImagePath).renameSync(newFilePath);

      return newFile.path;
    }
    return null;
  }

  static void _deleteImageFile({required String path}) {
    File(path).deleteSync();
  }

  static Future<void> deleteWish(WishModel wish) async {
    if (wish.imagePath != null) {
      _deleteImageFile(path: wish.imagePath!);
    }
    await box.delete(wish.id);
  }
}
