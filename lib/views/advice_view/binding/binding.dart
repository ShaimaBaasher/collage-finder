import 'package:get/instance_manager.dart';

import '../controller/controller.dart';

class AdviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdviceController>(
          () => AdviceController(),
    );
  }
}
