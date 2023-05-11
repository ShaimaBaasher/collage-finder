import 'package:collage_finder/admin/views/add_addmission_view/binding/binding.dart';
import 'package:collage_finder/admin/views/add_addmission_view/view/add_admission_view.dart';
import 'package:collage_finder/admin/views/add_advice_view/binding/binding.dart';
import 'package:collage_finder/admin/views/add_advice_view/view/add_advice_view.dart';
import 'package:collage_finder/admin/views/add_collage/view/add_collage_view.dart';
import 'package:collage_finder/admin/views/add_deartment_view/view/add_collage_view.dart';
import 'package:collage_finder/admin/views/add_rate_view/view/add_rate_view.dart';
import 'package:collage_finder/views/form_table_view/binding/binding.dart';
import 'package:collage_finder/views/form_table_view/views/form_table_view.dart';
import 'package:get/get.dart';

import '../../admin/views/add_area_view/binding/binding.dart';
import '../../admin/views/add_collage/binding/binding.dart';
import '../../admin/views/add_deartment_view/binding/binding.dart';
import '../../admin/views/add_rate_view/binding/binding.dart';
import '../../admin/views/add_university/binding/binding.dart';
import '../../admin/views/add_university/view/add_univresity_view.dart';
import '../../views/collage_view/binding/binding.dart';
import '../../views/splash_view/binding/binding.dart';
import '../../views/splash_view/view/splash_view.dart';
import '../../views/university_detials/view/university_detials_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const _transitionDuration = Duration(microseconds: 500);
  static const _transition = Transition.zoom;
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () =>  SplashView(),
      binding: SplashBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
    GetPage(
      name: _Paths.formview,
      page: () =>  FormTableView(),
      binding: FormTableBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
    GetPage(
      name: _Paths.universityDetailsView,
      page: () =>  UniversityDetailsView(),
      binding: CollageBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
    GetPage(
      name: _Paths.universityView,
      page: () =>  AddUniversityView(),
      binding: AddUniversityBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
    GetPage(
      name: _Paths.rateView,
      page: () =>  AddRateView(),
      binding: AddRateBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
    GetPage(
      name: _Paths.collageView,
      page: () =>  AddCollageView(),
      binding: AddCollageBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
    GetPage(
      name: _Paths.departmentView,
      page: () =>  AddDepartmentView(),
      binding: AddDepartmentBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
    GetPage(
      name: _Paths.rateView,
      page: () =>  AddRateView(),
      binding: AddAreaBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
    GetPage(
      name: _Paths.adviceView,
      page: () =>  AddAdviceView(),
      binding: AddAdviceBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
    GetPage(
      name: _Paths.admissionView,
      page: () =>  AddAdmissionView(),
      binding: AddAdmissionBinding(),
      transition: _transition,
      transitionDuration: _transitionDuration,),
  ];
}
