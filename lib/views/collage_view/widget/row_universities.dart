import 'package:collage_finder/views/collage_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/university_model.dart';
import '../../../utils/styles.dart';
import '../../../widgets/loading_widget.dart';

class RowUniversities extends StatelessWidget {
  RowUniversities({Key? key, required this.universityModel}) : super(key: key);
  final controller = Get.find<CollageController>();
  UniversityModel universityModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  '${universityModel?.img}',
                  width: 100.w,
                  height: 20.h,
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
                  width: 71.w,
                  height: 17.h,
                  fit: BoxFit.fitWidth,
                );
              }),
            ),
            SizedBox(height: 1.h,),
            SizedBox(
              height: 12.h,
              child: Obx(
                    () => controller.isUniversityLoading.isTrue
                    ? const LoadingWidget()
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: universityModel?.images?.length,
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {
                      // controller.changeDisplayMainImage(
                      //     '$GET_TRIP_BY_ID${homeController.tripModel?.id}/detail/image/${i + 1}');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.5, vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          '${universityModel?.images?[i].imageUrl}',
                          height: 5.h,
                          width: 19.w,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                    loadingProgress.expectedTotalBytes !=
                                        null
                                        ? loadingProgress
                                        .cumulativeBytesLoaded /
                                        loadingProgress
                                            .expectedTotalBytes!
                                        : null,
                                  )),
                            );
                          },
                          errorBuilder: (BuildContext context,
                              Object exception, StackTrace? stackTrace) {
                            return SvgPicture.asset(
                              'assets/icons/logo.svg',
                              height: 5.h,
                              width: 19.w,
                              fit: BoxFit.fitWidth,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${universityModel?.universityNameEn}',
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryTextStyle.copyWith(fontSize: 17.sp,),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      'Number of departments 97',
                      style: kLabelSecondryTextStyle.copyWith(fontSize: 13, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 2.5.h,
                        color: Colors.red,),
                      SizedBox(width: 1.w),
                      FittedBox(
                        child: Text(
                          'Baghdad',
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          style: kLabelSecondryTextStyle.copyWith(fontSize: 13, color: Colors.black87),
                        ),
                      ),
                    ],
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
