import 'package:get/get.dart';

import '../../views/splash_view/binding/binding.dart';
import '../../views/splash_view/view/splash_view.dart';
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
  ];
}
