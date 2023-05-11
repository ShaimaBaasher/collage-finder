import 'package:get/instance_manager.dart';

import '../controller/controller.dart';

class AddCollageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCollageController>(
          () => AddCollageController(),
    );
  }
}
