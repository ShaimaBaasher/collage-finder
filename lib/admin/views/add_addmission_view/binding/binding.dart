import 'package:get/instance_manager.dart';

import '../controller/add_admission_contoller.dart';

class AddAdmissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAdmissionController>(
          () => AddAdmissionController(),
    );
  }
}
