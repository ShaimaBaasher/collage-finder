import 'package:collage_finder/admin/views/more_view/controller/more_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/row_more.dart';

class MoreView extends StatelessWidget {
   MoreView({Key? key}) : super(key: key);

   final controller = Get.find<MoreController>();

   @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.moreList.length,
              itemBuilder: (ctx, i) => RowSingleImageNameWidget(
                   moreModel: controller.moreList[i]),),
          ],
        ),
      ),
    ));
  }
}
