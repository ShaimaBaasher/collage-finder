import 'package:get/get.dart';

import '../../bottom_bar_navigation_view/views/bottom_bar_navigation_view.dart';

class SplashController extends GetxController {

  void goToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => const BottomBarNavigationView());
  }

}
