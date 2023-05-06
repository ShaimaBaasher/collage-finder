import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/filter_model.dart';
import '../../../utils/styles.dart';
import '../../rate_view/controller/controller.dart';

class RowFilter extends StatelessWidget {

  final controller = Get.find<RateController>();

  int index;
  FilterModel filterModel;
  int isGenderOnly;

  RowFilter({Key? key, required this.index, required this.filterModel, required this.isGenderOnly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          controller.isItemSelected(index, filterModel);
        },
        child: GetBuilder<RateController>(builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 1.2.w),
              decoration: BoxDecoration(
                color: isGenderOnly == 1 ? controller.selectedSpecialtyCategoryIndex == index   ? kPurpleColor
                : kPurpleLightColor : controller.selectedGenderIndex == index  ? kPurpleColor
                : kPurpleLightColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                      '${filterModel.filterName}',
                      style: kRadioLabelTextStyle.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.sp,
                          color:
                          isGenderOnly == 1 ? controller.selectedSpecialtyCategoryIndex ==
                              index
                              ? Colors.white
                              : kPurpleColor : controller.selectedGenderIndex == index  ? Colors.white
                          : kPurpleColor)),
                ),
              ));
        }),
      ),
    );
  }
}
