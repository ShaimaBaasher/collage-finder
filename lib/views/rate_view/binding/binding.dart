import 'package:get/instance_manager.dart';

import '../controller/controller.dart';

class RateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateController>(
          () => RateController(),
    );
  }
}
