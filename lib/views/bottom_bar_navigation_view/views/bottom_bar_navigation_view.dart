import 'package:collage_finder/views/rate_view/view/rate_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/styles.dart';
import '../../../utils/translation/app_language.dart';
import '../../../utils/storage/storage_service.dart';
import '../../advice_view/view/advice_view.dart';
import '../../collage_view/view/collage_view.dart';
import '../../form_view/view/form_view.dart';


class BottomBarNavigationView extends StatefulWidget {
  static List<Widget> widgetOptions = [
     FormView(),
     RateView(),
     AdviceView(),
     CollageView(),
  ];

  const BottomBarNavigationView({Key? key}) : super(key: key);

  @override
  State<BottomBarNavigationView> createState() => _BottomBarNavigationView();
}

class _BottomBarNavigationView extends State<BottomBarNavigationView> {
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
        return BottomBarNavigationView.widgetOptions
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
              label: "resume".tr),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_file_search.svg',
                color: _currentTabIndex == 1 ? Colors.indigo : Colors.grey,
              ),
              label: "rate".tr),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_help.svg',
                color: _currentTabIndex == 2 ? Colors.indigo : Colors.grey,
              ),
              label: "advices".tr),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_collage.svg',
                color: _currentTabIndex == 3 ? Colors.indigo : Colors.grey,
              ),
              label: "collages".tr),
        ],
      ),
    );
  }
}
