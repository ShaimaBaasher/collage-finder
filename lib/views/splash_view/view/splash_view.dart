import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../widgets/loading_widget.dart';
import '../controller/controller.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final controller = Get.find<SplashController>();

  @override
  void initState() {
    controller.goToHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned(
              bottom: 50, left: 10, right: 10, child: LoadingWidget()),
          Positioned(
            top: 300,
            left: 10,
            right: 10,
            child: Container(
              alignment: Alignment.center, // use aligment
              child: SvgPicture.asset('assets/icons/logo.svg',
                  height: 80, width: 150, fit: BoxFit.fitWidth),
            ),
          ),
        ],
      ),
    );
  }
}
