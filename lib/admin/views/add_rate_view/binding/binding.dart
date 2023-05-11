import 'package:get/instance_manager.dart';

import '../controller/controller.dart';

class AddRateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRateController>(
          () => AddRateController(),
    );
  }
}
