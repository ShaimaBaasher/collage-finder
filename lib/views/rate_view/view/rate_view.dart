import 'package:collage_finder/views/rate_view/controller/controller.dart';
import 'package:collage_finder/views/rate_view/widgets/row_university.dart';
import 'package:collage_finder/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../models/area_model.dart';
import '../../../utils/styles.dart';
import '../widgets/row_filter.dart';

class RateView extends StatelessWidget {
  RateView({Key? key}) : super(key: key);
  final form = GlobalKey<FormState>();
  final controller = Get.find<RateController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 20.h,
                  width: size.width,
                  color: Colors.indigo,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        'This is 2022 Admission Rate, Good Luck !',
                        textAlign: TextAlign.start,
                        style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 18.sp, color: Colors.white),),
                        Obx(() => controller.isAreaLoading.isTrue ? LoadingWidget() : DropdownButton<AreaModel>(
                            dropdownColor: Colors.black87, //<-- SEE HERE
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white, // <-- SEE HERE
                            ),
                            value: controller.areaList[0],
                            items: controller.areaList.map<DropdownMenuItem<AreaModel>>((value) => DropdownMenuItem<AreaModel>(
                              value: value,
                              child: FittedBox(
                                child: Text(
                                  '${value.areaName}',
                                  style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 17.sp, color: Colors.white),),
                              ),
                            )).toList(),
                            onChanged: (newValue) {
                              controller.dropdownValue = newValue!;
                            },
                          ),
                        ),
                        SizedBox(height: 5.h,),
                      ],),
                  ),
                ),
                Container(
                  height: 23.h,
                ),
                Positioned(
                    top: 105,
                    right: 20,
                    child: Form(
                      key: form,
                      child: Container(
                        width: size.width * 0.9,
                        height: size.height * 0.4,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: indicatorColor, width: 0.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.search),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.5, color: Colors.blue), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              constraints: const BoxConstraints(
                                  maxHeight: 50, minHeight: 50),
                              filled: true,
                              hintStyle: kTextFieldTextStyle,
                              hintText: "search_by_collage_or_department".tr,
                              fillColor: Colors.white),
                          validator: (value) {
                            if (value != null) if (value.trim().isEmpty) {
                              return 'please_provide_value'.tr;
                            } else {
                              // controller.emailAddress = value.trim();
                            }
                            return null;
                          },
                          onChanged: (value) {
                            controller.searcBox = value;
                            controller.filter();
                          },
                          onFieldSubmitted: (_) {},
                        ),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'enter_rate'.tr,
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 18.sp),),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: GetBuilder<RateController>(
                      builder: (_) {
                        return SfRangeSlider(
                          min: 10,
                          max: 100,
                          values: controller.sfRangeValues,
                          showLabels: true,
                          activeColor: kPurpleColor,
                          // interval: 3000.0,
                          enableTooltip: true,
                          onChanged: (SfRangeValues newValues) {
                            controller.updateRangeSlider(newValues);
                            controller.sfRangeValues = newValues;
                          },
                        );
                      }
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // Row(
                  //   children: [
                  //     Wrap(
                  //       children: [
                  //         SizedBox(
                  //             height: 7.h,
                  //             child: Card(
                  //               child: ListView.builder(
                  //                 shrinkWrap: true,
                  //                 physics: const NeverScrollableScrollPhysics(),
                  //                 scrollDirection: Axis.horizontal,
                  //                 itemCount: controller.durationList.length,
                  //                 itemBuilder: (ctx, index) {
                  //                   return RowFilter(
                  //                       index: index,
                  //                       filterModel:
                  //                           controller.durationList[index], isGenderOnly: 3,);
                  //                 },
                  //               ),
                  //             )),
                  //       ],
                  //     ),
                  //     Wrap(
                  //       children: [
                  //         SizedBox(
                  //             height: 7.h,
                  //             child: Card(
                  //               child: ListView.builder(
                  //                 shrinkWrap: true,
                  //                 physics: const NeverScrollableScrollPhysics(),
                  //                 scrollDirection: Axis.horizontal,
                  //                 itemCount:
                  //                     controller.universitySectorList.length,
                  //                 itemBuilder: (ctx, index) {
                  //                   return RowFilter(
                  //                       index: index,
                  //                       filterModel: controller
                  //                           .universitySectorList[index], isGenderOnly: 3);
                  //                 },
                  //               ),
                  //             )),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                              height: 7.h,
                              child: Card(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.genderList.length,
                                  itemBuilder: (ctx, index) {
                                    return RowFilter(
                                        index: index,
                                        filterModel:
                                            controller.genderList[index], isGenderOnly: 2);
                                  },
                                ),
                              )),
                        ],
                      ),
                      // Wrap(
                      //   children: [
                      //     SizedBox(
                      //         height: 7.h,
                      //         child: Card(
                      //           child: ListView.builder(
                      //             shrinkWrap: true,
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             scrollDirection: Axis.horizontal,
                      //             itemCount: controller.dateList.length,
                      //             itemBuilder: (ctx, index) {
                      //               return RowFilter(
                      //                   index: index,
                      //                   filterModel:
                      //                       controller.dateList[index], isGenderOnly: 3);
                      //             },
                      //           ),
                      //         )),
                      //   ],
                      // ),
                    ],
                  ),
                  Wrap(
                    children: [
                      SizedBox(
                          height: 7.h,
                          child: Card(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.specialtyCategoryList.length,
                              itemBuilder: (ctx, index) {
                                return RowFilter(
                                    index: index,
                                    filterModel: controller
                                        .specialtyCategoryList[index], isGenderOnly: 1);
                              },
                            ),
                          )),
                    ],
                  ),
                  Obx(
                    () => controller.isUniversityLoaded.isTrue
                        ? LoadingWidget()
                        : GetBuilder<RateController>(
                          builder: (_) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.filterList.length,
                                itemBuilder: (ctx, i) => RowUniversity(
                                      universityModel:
                                          controller.filterList[i],
                                    ));
                          }
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
