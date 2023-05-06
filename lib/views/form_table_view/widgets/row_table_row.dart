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
                '${controller.items[index]["field_id"]} - ',
                style: kLabelPrimaryTextStyle.copyWith(
                    fontSize: 18.sp, color: Colors.black87),),
              SizedBox(width: 2.w,),
              Expanded(
                child: Text(
                  '${controller.items[index]["itinerary"]}',
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
