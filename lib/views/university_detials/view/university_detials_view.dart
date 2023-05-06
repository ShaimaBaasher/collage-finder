import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/styles.dart';
import '../../collage_view/controller/controller.dart';

class UniversityDetailsView extends StatelessWidget {
  UniversityDetailsView({Key? key}) : super(key: key);
  final controller = Get.find<CollageController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
              child: GetBuilder<CollageController>(
                builder: (_) => Image.network(
                    '${controller.universityModel?.img}',
                    width: size.width,
                    height: 40.h,
                    fit: BoxFit.cover, loadingBuilder: (BuildContext context,
                        Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    )),
                  );
                }, errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/images/logo.png',
                    height: 50.h,
                    width: 50.w,
                    fit: BoxFit.fitWidth,
                  );
                }),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${controller.universityModel?.universityNameEn}',
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryTextStyle.copyWith(
                      fontSize: 19.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text('${controller.universityModel?.about}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: kLabelSecondryTextStyle.copyWith(fontSize: 12),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'About',
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryTextStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
