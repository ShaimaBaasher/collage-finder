import 'package:get/instance_manager.dart';

import '../controller/controller.dart';

class FormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormController>(
          () => FormController(),
    );
  }
}
