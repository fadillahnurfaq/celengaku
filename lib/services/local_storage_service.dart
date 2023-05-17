import 'package:celenganku/models/saving_model.dart';
import 'package:celenganku/models/wish_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<WishModel> box;

class LocalStorageApi {
  static final Box<WishModel> _box = box;

  static const String keyName = '__celengan__';

  static List<WishModel> getWishList() {
    return _box.values.toList();
  }

  static Future saveWish(WishModel wish) async {
    return await _box.put(wish.id, wish);
  }

  static Future<void> deleteWish(String id) async {
    return await _box.delete(id);
  }

  static Future<void> addSaving(String id, SavingModel saving) async {
    WishModel wish = _box.get(id) as WishModel;

    wish.copyWith(listSaving: [...wish.listSaving, saving]);

    return await _box.put(id, wish);
  }
}
