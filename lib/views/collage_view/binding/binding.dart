import 'package:get/instance_manager.dart';

import '../controller/controller.dart';

class CollageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollageController>(
          () => CollageController(),
    );
  }
}
