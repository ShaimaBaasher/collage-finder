import 'package:collage_finder/views/form_view/controller/controller.dart';
import 'package:get/instance_manager.dart';

class FormTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormController>(
          () => FormController(),
    );
  }
}
