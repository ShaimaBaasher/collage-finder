import 'package:collage_finder/models/collage_model.dart';
import 'package:collage_finder/views/collage_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/university_model.dart';
import '../../../utils/styles.dart';
import '../../../widgets/divider_widget.dart';

class RowCollage extends StatelessWidget {
  final controller = Get.find<CollageController>();
  CollageModel collageModel;

  RowCollage({Key? key, required this.collageModel}) : super(key: key);

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
              Expanded(
                child: Text(
                  '${collageModel.collageNameEn}',
                  style: kLabelPrimaryNormalTextStyle.copyWith(
                      fontSize: 18.sp, color: Colors.black87),),
              ),
            ],),
            const DividerWidget()
          ],
        ),
      ),
    );
  }
}
