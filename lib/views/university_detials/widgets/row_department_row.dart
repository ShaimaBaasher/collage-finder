import 'package:collage_finder/views/collage_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/university_model.dart';
import '../../../utils/styles.dart';
import '../../../widgets/divider_widget.dart';

class RowDepartment extends StatelessWidget {
  final controller = Get.find<CollageController>();
  UniversityModel universityModel;

  RowDepartment({Key? key, required this.index, required this.universityModel}) : super(key: key);
  int index;

  // FilterModel filterModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Text(
                ' ',
                style: kLabelPrimaryTextStyle.copyWith(
                    fontSize: 18.sp, color: Colors.black87),),
              SizedBox(width: 2.w,),
              Expanded(
                child: Text(
                  ' ',
                  style: kLabelPrimaryTextStyle.copyWith(
                      fontSize: 18.sp, color: Colors.black87),
                ),
              ),
            ],),
            const DividerWidget()
          ],
        ),
      ),
    );
  }
}
