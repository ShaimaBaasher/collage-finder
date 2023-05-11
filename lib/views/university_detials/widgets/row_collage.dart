import 'package:collage_finder/models/collage_model.dart';
import 'package:collage_finder/views/collage_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/styles.dart';
import '../../../widgets/divider_widget.dart';

class RowCollage extends StatelessWidget {
  final controller = Get.find<CollageController>();
  CollageModel collageModel;
  int index;

  RowCollage({Key? key, required this.index, required this.collageModel})
      : super(key: key);

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
                CircleAvatar(
                  backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.6),
                  child: GetBuilder<CollageController>(builder: (_) {
                    return IconButton(
                      icon: Icon(
                          collageModel.isSaved! ||
                                  controller.savedUniversityIndex == index
                              ? Icons.remove
                              : Icons.add,
                          size: 20),
                      color: collageModel.isSaved! ||
                              controller.savedUniversityIndex == index
                          ? Colors.red
                          : Colors.green,
                      onPressed: () {
                        collageModel.isSaved! ||
                                controller.savedUniversityIndex == index
                            ? controller.removeUniversityForm(
                                index, collageModel)
                            : controller.saveUniversityForm(
                                index, collageModel);
                      },
                    );
                  }),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${collageModel.collageNameEn}',
                          style: kLabelPrimaryNormalTextStyle.copyWith(
                              fontSize: 18.sp, color: Colors.black87),
                        ),
                      ),
                      Text(
                        collageModel.rate != null ? '${collageModel.rate}%' : '',
                        style: kLabelPrimaryNormalTextStyle.copyWith(
                            fontSize: 18.sp, color: Colors.green),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const DividerWidget()
          ],
        ),
      ),
    );
  }
}
