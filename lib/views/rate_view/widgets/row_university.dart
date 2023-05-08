import 'package:collage_finder/models/university_admission_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/styles.dart';

class RowUniversity extends StatelessWidget {
  UniversityAdmissionModel universityModel;

  RowUniversity({Key? key, required this.universityModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network('${universityModel.universityModel?.img}',
                    width: 25.w,
                    height: 15.h,
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
                      return SvgPicture.asset(
                        'assets/icons/logo.svg',
                        width: 25.w,
                        height: 15.h,
                        fit: BoxFit.fitWidth,
                      );
                    }),
              ),
              Expanded(
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${universityModel.universityModel?.universityNameEn}',
                        textAlign: TextAlign.start,
                        style: kLabelPrimaryTextStyle.copyWith(fontSize: 17.sp,),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 0.5.h,
                      ),
                      SizedBox(
                        width: size.width / 2,
                        child: Text(
                          '${universityModel.collageModel?.collageNameEn}',
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          // new
                          style: kLabelSecondryTextStyle.copyWith(fontSize: 13, color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      SizedBox(
                        width: size.width / 2,
                        child: Text(
                          universityModel.departmentModel?.departmentNameEn ?? '',
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          // new
                          style: kLabelSecondryTextStyle.copyWith(fontSize: 13, color: Colors.black87),
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 2.5.h,
                            color: Colors.red,),
                          SizedBox(width: 1.w),
                          FittedBox(
                            child: Text(
                              '${universityModel.universityModel?.areaModel?.areaName}',
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: kLabelSecondryTextStyle.copyWith(fontSize: 13, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
                Text(
                  '${universityModel.rateModel?.total} %',
                  overflow: TextOverflow.ellipsis,
                  // new
                  style: kLabelSecondryTextStyle.copyWith(fontSize: 17.sp, color: kPurpleColor, fontWeight: FontWeight.bold),
                ),
              ],),
          ],
        ),
      ),
    );
  }
}
