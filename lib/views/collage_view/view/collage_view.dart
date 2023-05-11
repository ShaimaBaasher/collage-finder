import 'package:collage_finder/views/collage_view/widget/row_universities.dart';
import 'package:collage_finder/views/rate_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/styles.dart';
import '../../../widgets/loading_widget.dart';
import '../controller/controller.dart';

class CollageView extends StatelessWidget {
  CollageView({Key? key}) : super(key: key);

  final controller = Get.find<CollageController>();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text("Universities"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2.h,),
              Form(
                key: form,
                child: SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: indicatorColor, width: 0.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0.5, color: Colors.blue),
                          //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
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
                      controller.searchBox = value;
                      controller.filter();
                    },
                    onFieldSubmitted: (_) {},
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              Obx(() => controller.isUniversityLoading.isTrue
                  ? const LoadingWidget()
                  : GetBuilder<CollageController>(
                    builder: (_) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.filterList.length,
                          itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              controller.openUniversityDetails(controller.universityList[i]) ;
                            },
                            child: RowUniversities(
                                universityModel: controller.filterList[i]),
                          ));
                    }
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
