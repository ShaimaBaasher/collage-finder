import 'package:get/get.dart';

import 'storage_service.dart';

abstract class BaseService {
  Future<void> init() async {}
}

abstract class AppServices {
  static Future<void> init() async {
    await Get.put(StorageService()).init();
  }
}
