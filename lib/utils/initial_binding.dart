import 'package:collage_finder/admin/views/add_advice_view/controller/controller.dart';
import 'package:collage_finder/admin/views/add_area_view/controller/controller.dart';
import 'package:collage_finder/views/advice_view/controller/controller.dart';
import 'package:collage_finder/views/collage_view/controller/controller.dart';
import 'package:collage_finder/views/form_table_view/contoller/controller.dart';
import 'package:collage_finder/views/form_view/controller/controller.dart';
import 'package:collage_finder/views/rate_view/controller/controller.dart';
import 'package:get/instance_manager.dart';
import '../admin/views/add_addmission_view/controller/add_admission_contoller.dart';
import '../admin/views/add_collage/controller/controller.dart';
import '../admin/views/add_department_view/controller/controller.dart';
import '../admin/views/add_rate_view/controller/controller.dart';
import '../admin/views/add_university/controller/controller.dart';
import '../admin/views/more_view/controller/more_controller.dart';
import '../views/splash_view/controller/controller.dart';
import 'translation/app_language.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdviceController());
    Get.put(CollageController());
    Get.put(FormTableController());
    Get.put(FormController());
    Get.put(RateController());
    Get.put(SplashController());
    Get.put(AppLanguage());
    Get.put(AddUniversityController());
    Get.put(AddRateController());
    Get.put(AddCollageController());
    Get.put(AddDepartmentController());
    Get.put(AddAdmissionController());
    Get.put(AddAreaController());
    Get.put(MoreController());
    Get.put(AddAdviceController());
  }
}
