import 'package:collage_finder/admin/views/add_advice_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/styles.dart';

class AddAdviceView extends StatelessWidget {

  AddAdviceView({Key? key}) : super(key: key);

  final controller = Get.find<AddAdviceController>();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            centerTitle: true,
            title: const Text("Add Advice"),
          ),
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 1.h,),
              Form(
                key: form,
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width ,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(
                                  color: indicatorColor, width: 0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.5, color: Colors.blue),
                              //<-- SEE HERE
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            constraints: const BoxConstraints(
                                maxHeight: 50, minHeight: 50),
                            filled: true,
                            hintStyle: kTextFieldTextStyle,
                            hintText: "Enter Question",
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value != null) if (value
                              .trim()
                              .isEmpty) {
                            return 'please_provide_value'.tr;
                          } else {
                            // controller.emailAddress = value.trim();
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.question = value;
                        },
                        onFieldSubmitted: (_) {},
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    SizedBox(
                      width: size.width ,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: indicatorColor, width: 0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.5, color: Colors.blue),
                              //<-- SEE HERE
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            constraints: const BoxConstraints(
                                maxHeight: 50, minHeight: 50),
                            filled: true,
                            hintStyle: kTextFieldTextStyle,
                            hintText: "Add Answer",
                            fillColor: Colors.white),
                        validator: (value) {
                          if (value != null) if (value
                              .trim()
                              .isEmpty) {
                            return 'please_provide_value'.tr;
                          } else {
                            // controller.emailAddress = value.trim();
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.answer = value;
                        },
                        onFieldSubmitted: (_) {},
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Obx(() =>
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,),
                onPressed: controller.isInsertingLoading.isTrue ? null : () {
                  controller.uploadAdvice();
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Advice"),),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
