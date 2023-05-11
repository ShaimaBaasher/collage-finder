import 'package:get/instance_manager.dart';

import '../controller/controller.dart';

class AddDepartmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDepartmentController>(
          () => AddDepartmentController(),
    );
  }
}
