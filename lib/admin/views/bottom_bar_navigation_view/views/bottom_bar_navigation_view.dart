import 'package:collage_finder/admin/views/add_addmission_view/view/add_admission_view.dart';
import 'package:collage_finder/admin/views/add_area_view/view/add_area_view.dart';
import 'package:collage_finder/admin/views/add_collage/view/add_collage_view.dart';
import 'package:collage_finder/admin/views/add_rate_view/view/add_rate_view.dart';
import 'package:collage_finder/admin/views/add_university/view/add_univresity_view.dart';
import 'package:collage_finder/views/rate_view/view/rate_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/storage/storage_service.dart';
import '../../../../utils/translation/app_language.dart';
import '../../more_view/view/more_view.dart';

class AdminBottomBarNavigationView extends StatefulWidget {
  static List<Widget> widgetOptions = [
    AddUniversityView(),
    AddCollageView(),
    AddRateView(),
    MoreView(),
  ];

  const AdminBottomBarNavigationView({Key? key}) : super(key: key);

  @override
  State<AdminBottomBarNavigationView> createState() =>
      _BottomBarNavigationView();
}

class _BottomBarNavigationView extends State<AdminBottomBarNavigationView> {
  int _currentTabIndex = StorageService.to.homePageIndex!;
  int _oldTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AppLanguage>(
        init: AppLanguage(),
        builder: (_) {
          _oldTabIndex = _currentTabIndex;
          StorageService.to.setHomePageIndex(_currentTabIndex);
          return AdminBottomBarNavigationView.widgetOptions
              .elementAt(StorageService.to.homePageIndex!);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: _currentTabIndex,
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_resume.svg',
                color: _currentTabIndex == 0 ? Colors.indigo : Colors.grey,
                width: 24,
                height: 24,
              ),
              label: "Add University"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_file_search.svg',
                color: _currentTabIndex == 1 ? Colors.indigo : Colors.grey,
              ),
              label: "Add Collage"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_help.svg',
                color: _currentTabIndex == 2 ? Colors.indigo : Colors.grey,
              ),
              label: "Add Rate"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_more.svg',
                color: _currentTabIndex == 3 ? Colors.indigo : Colors.grey,
              ),
              label: "More"),
        ],
      ),
    );
  }
}
