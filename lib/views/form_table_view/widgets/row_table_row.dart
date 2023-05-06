import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/styles.dart';
import '../../../widgets/divider_widget.dart';
import '../contoller/controller.dart';

class RowTableRow extends StatelessWidget {
  final controller = Get.find<FormTableController>();

  RowTableRow({Key? key, required this.index,}) : super(key: key);
  int index;

  // FilterModel filterModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${controller.items[index]["itinerary"]}',
          style: kLabelPrimaryNormalTextStyle.copyWith(
              fontSize: 18.sp, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
        const DividerWidget()
      ],
    );
  }
}
