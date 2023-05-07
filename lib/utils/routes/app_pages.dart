import 'package:collage_finder/views/form_table_view/binding/binding.dart';
import 'package:collage_finder/views/form_table_view/views/form_table_view.dart';
import 'package:collage_finder/views/free_trial_view/view/FreeTrialView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  ];
}
