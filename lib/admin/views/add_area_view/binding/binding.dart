import 'package:collage_finder/admin/views/add_area_view/controller/controller.dart';
import 'package:get/instance_manager.dart';


class AddAreaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAreaController>(
          () => AddAreaController(),
    );
  }
}
