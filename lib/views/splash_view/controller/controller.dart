
import 'package:collage_finder/utils/storage/storage_service.dart';
import 'package:get/get.dart';

import '../../../admin/views/bottom_bar_navigation_view/views/bottom_bar_navigation_view.dart';
import '../../bottom_bar_navigation_view/views/bottom_bar_navigation_view.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    goToHomeScreen();
    super.onInit();
  }
  void goToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    StorageService.to.reset();
    Get.off(() => const AdminBottomBarNavigationView());
  }

}
