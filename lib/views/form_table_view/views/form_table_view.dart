import 'package:collage_finder/views/form_table_view/widgets/row_table_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/styles.dart';
import '../contoller/controller.dart';

class FormTableView extends StatelessWidget {
  final controller = Get.find<FormTableController>();

  FormTableView({Key? key}) : super(key: key);
  static final GlobalKey _globalKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        actions: [
          SizedBox(width: 2.w,),
          IconButton(
            icon: const Icon(Icons.share),
            color: Colors.white, onPressed: () async {
            await controller.shareReceipt(_globalKey);
          },),
          SizedBox(width: 2.w,),
          IconButton(
            icon: const Icon(Icons.download),
            color: Colors.white, onPressed: () async {
              await controller.takeScreenshot(_globalKey);
          },),
          SizedBox(width: 2.w,),
        ],
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 10.h,
                width: size.width,
                color: Colors.indigo,
                child: Center(
                    child: Text(
                  "Virtual Application Form",
                  style: kLabelPrimaryNormalTextStyle.copyWith(
                      color: Colors.white, fontSize: 19.sp),
                )),
              ),
              SizedBox(
                height: 2.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: controller.items.length,
                itemBuilder: (ctx, index) {
                  return RowTableRow(
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
