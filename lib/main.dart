import 'package:collage_finder/utils/initial_binding.dart';
import 'package:collage_finder/utils/routes/app_pages.dart';
import 'package:collage_finder/utils/storage/base_service.dart';
import 'package:collage_finder/utils/translation/translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'utils/firebase/firebase_options.dart';

void main() async {
  await _init();
  runApp(const CollageFinder());
}

Future<void> _init() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options : DefaultFirebaseOptions.currentPlatform
  );

  // initializeDateFormatting();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await AppServices.init();
  InitialBinding().dependencies();

}

class CollageFinder extends StatelessWidget {
  const CollageFinder({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder:  (context, o, f) {
          return GetMaterialApp(
            builder: EasyLoading.init(),
            translations: Translation(),
            title: 'app_name'.tr,
            debugShowCheckedModeBanner: false,
            getPages: AppPages.routes,
            initialRoute: Routes.splash,
          );
        }
    );
  }
}
