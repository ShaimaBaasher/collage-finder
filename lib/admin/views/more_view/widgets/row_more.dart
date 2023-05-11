import 'package:collage_finder/admin/views/more_view/controller/more_controller.dart';
import 'package:collage_finder/models/more_model.dart';
import 'package:collage_finder/widgets/divider_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/styles.dart';

class RowSingleImageNameWidget extends StatelessWidget {
  final controller = Get.find<MoreController>();

  final MoreModel moreModel;

  RowSingleImageNameWidget({Key? key, required this.moreModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ListTile(
            onTap: () {
              controller.whichRouteToGo(context, moreModel.id!);
            },
            title: Text('${moreModel.name}'.tr, style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 18.sp),),
            trailing: const Icon(Icons.arrow_forward_ios, size: 23,),
          ),
          DividerWidget()
        ],
      ),
    );
  }
}
