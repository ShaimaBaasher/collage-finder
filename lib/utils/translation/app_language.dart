import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../storage/storage_service.dart';
import 'local_storage.dart';

class AppLanguage extends GetxController {
  String appLocale = 'en';

  @override
  void onInit() async {
    super.onInit();
    LocalStorage localStorage = LocalStorage();

    appLocale = StorageService.to.language ?? 'en';
    printInfo(info: 'appLocale $appLocale');
    update();
    Get.updateLocale(Locale(appLocale));
  }

  void changeLanguage(String type) async {
    LocalStorage localStorage = LocalStorage();

    if (appLocale == type) {
      return;
    }

    if (type == 'ar') {
      appLocale = 'ar';
      StorageService.to.setLanguage('ar');
      localStorage.saveLanguage('ar');
      // controller.initWalletView();
      // placeController.mIsLanguageArabic(true);

      // placeController.durationUnitFilter();
    } else {
      appLocale = 'en';
      StorageService.to.setLanguage('en');
      localStorage.saveLanguage('en');
      // controller.initWalletView();
      // placeController.mIsLanguageArabic(false);

      // placeController.durationUnitFilter();
    }
    update();
  }
}
