import 'package:collage_finder/views/form_table_view/contoller/controller.dart';
import 'package:collage_finder/views/form_view/controller/controller.dart';
import 'package:collage_finder/views/rate_view/controller/controller.dart';
import 'package:get/instance_manager.dart';
import '../views/splash_view/controller/controller.dart';
import 'translation/app_language.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FormTableController());
    Get.put(FormController());
    Get.put(RateController());
    Get.put(SplashController());
    Get.put(AppLanguage());
  }
}
