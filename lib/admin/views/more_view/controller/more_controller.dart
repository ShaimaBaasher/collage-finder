import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../models/more_model.dart';
import '../../../../utils/routes/app_pages.dart';

class MoreController extends GetxController {

  final moreList = [
    MoreModel(
      id: 1,
      name: 'Add University',
      icon: 'assets/icons/ic_profile.svg',),
    MoreModel(
      id: 2,
      name: 'Add Collage',
      icon: 'assets/icons/ic_favourite.svg',),
    MoreModel(
      id: 3,
      name: 'Add Department',
      icon: 'assets/icons/ic_rectangle_check.svg',),
    MoreModel(
      id: 4,
      name: 'Add Admission',
      icon: 'assets/icons/ic_rectangle_check.svg',),
    MoreModel(
      id: 5,
      name: 'Add Rate',
      icon: 'assets/icons/ic_rectangle_check.svg',),
    MoreModel(
      id: 6,
      name: 'Add Advice',
      icon: 'assets/icons/ic_rectangle_check.svg',),
  ];

  void whichRouteToGo(BuildContext context, int Id) {
    // this.serviceModel = serviceModel!;
    switch (Id) {
      case 1:
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.universityView);
        break;
      case 2:
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.collageView);
        // Get.toNamed(Routes.favourites,);
        break;
      case 3:
        Get.toNamed(Routes.departmentView, );
        break;
      case 4:
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.admissionView);
        break;
      case 5:
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.rateView);
        break;
      case 6:
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.adviceView);
        break;
    }
  }

}