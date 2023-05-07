import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/utils/constaints.dart';
import 'package:collage_finder/views/free_trial_view/view/FreeTrialView.dart';
import 'package:get/get.dart';

import '../../bottom_bar_navigation_view/views/bottom_bar_navigation_view.dart';

class SplashController extends GetxController {

  var isAppOnline = false;

  @override
  void onInit() {
    getIsAppOnline();
    super.onInit();
  }
  void goToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => const BottomBarNavigationView());
  }

  Future getIsAppOnline() async {
    QuerySnapshot querySnapshot = await APP_ONLINE_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    isAppOnline = universities['isOnline'] as bool;

    if (isAppOnline) {
      goToHomeScreen();
    } else {
      Get.off(() => const FreeTrailView());
    }
  }
}
