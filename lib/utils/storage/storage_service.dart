import 'dart:convert';

import 'package:collage_finder/models/university_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/save_uni_model.dart';
import 'base_service.dart';

class StorageService extends GetxService implements BaseService {
  static StorageService get to => Get.find<StorageService>();
  late GetStorage _box;

  @override
  Future<void> init() async {
    _box = GetStorage('settings');

    await _box.initStorage;
  }

  void reset() async {
    await _box.erase();
  }

  String? get universityPhotoUrl => _box.read(_Keys.universityImage);

  void setUniversityImage(String? photoUrl) => _box.write(_Keys.universityImage, photoUrl);

  String? get language => _box.read(_Keys.language) ?? 'en';

  void setLanguage(String? language) => _box.write(_Keys.language, language);

  void removeKey(String key) async {
    await _box.remove(key);
  }

  int? get homePageIndex => _box.read(_Keys.homeIndex) ?? 0;

  void setHomePageIndex(int? homeIndex) => _box.write(_Keys.homeIndex, homeIndex);

  void setUniversityList(List<SavedUniModel> universityModelList) {
    final cardList = universityModelList.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(cardList);
    _box.write(_Keys.universityModelList, jsonString);
    printInfo(info: 'setCardModel $jsonString');
  }

  Future<List<SavedUniModel>?> getUniversityList() async {
    List<SavedUniModel>? jsonData;
    final result = await _box.read(_Keys.universityModelList);
    if (result != null) {
      savedUniModelListFromJson(result) != null ? jsonData = savedUniModelListFromJson(result) : jsonData = [];
    } else {
      jsonData = [];
    }
    printInfo(info: 'getCardModel $result');
    return jsonData;
  }

}

abstract class _Keys {
  static const String  language = 'language';
  static const String  homeIndex = 'homeIndex';
  static const String  universityModelList = 'universityModelList';
  static const String  universityImage = 'universityImage';
}
