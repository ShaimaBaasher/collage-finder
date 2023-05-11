import 'package:get/instance_manager.dart';

import '../controller/controller.dart';

class AddUniversityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUniversityController>(
          () => AddUniversityController(),
    );
  }
}
