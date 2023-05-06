import 'package:get/get.dart';

class AdviceController extends GetxController {

  void goToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    // StorageService.to.isLoggedIn == true ? Get.off(() => const BottomBarNavigationView()) : Get.off(() => const OnBoarding());
  }

}
