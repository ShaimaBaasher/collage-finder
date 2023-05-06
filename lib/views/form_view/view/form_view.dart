import 'package:collage_finder/views/form_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/styles.dart';

class FormView extends StatefulWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  State<FormView> createState() => _DynamicFieldsState();
}

class _DynamicFieldsState extends State<FormView> {
  // List<Widget> list = [];

  // List<Map<String, dynamic>> items = [];

  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<FormController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: const Text("Virtual Application Form"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 2.h,),
                  Text(
                    'application_for_colleges_and_institutes'.tr,
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryTextStyle.copyWith(fontSize: 19.sp),),
                  SizedBox(height: 2.h),
                  Obx(() => controller.fieldCount.value == 0
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "No Colleges and Institutes added!",
                                style: kLabelSecondryTextStyle.copyWith(
                                    fontSize: 18.sp),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.list.length,
                                itemBuilder: (_, i) => buildField(i),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Fields missing")));
                                    } else {
                                      // TODO Create Table View Form
                                      confirmGenerateTableDialog(context);
                                    }
                                  },
                                  child: const Text("Validate")),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Text("ADD\nNEW"),
          onPressed: () {
            // controller.addNewFiled();
            setState(() {
              if (controller.fieldCount.value <= 25) {
                controller.fieldCount.value++;
                controller.list.add(buildField(controller.fieldCount.value));
              }
            });
          },
        ),
      ),
    );
  }

  confirmGenerateTableDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Generate Table"),
            content: Text('Would you like to generate your selected Colleges ? '),
            actions: [
              TextButton(
                // FlatButton widget is used to make a text to work like a button
                onPressed: () {
                  Navigator.pop(context);
                }, // function used to perform after pressing the button
                child: Text('Cancel'),
              ),
              TextButton(
                // FlatButton widget is used to make a text to work like a button
                onPressed: () {
                  controller.goToGenerateFormTable();
                  // Navigator.pop(context);
                }, // function used to perform after pressing the button
                child: Text('Generate'),
              ),
            ],
          );
        });
  }

  // itinerariesDialog(BuildContext context) {
  //   showDialog(
  //       barrierDismissible: true,
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text("Stored Colleges and Institutes"),
  //           content: SizedBox(
  //             width: double.maxFinite,
  //             child: ListView(
  //               shrinkWrap: true,
  //               children:
  //                   controller.items.map((e) => Text(e["itinerary"].trim())).toList(),
  //             ),
  //           ),
  //         );
  //       });
  // }

  Widget buildField(int i) {
    return ListTile(
      leading: CircleAvatar(
        child: Text((i + 1).toString()),
      ),
      title: TextFormField(
        initialValue: controller.items.length > i ? controller.items[i]["itinerary"] : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          labelText: "${'college_or_institute'.tr} ${i + 1}",
        ),
        onChanged: (data) => controller.storeValue(i + 1, data),
        validator: (val) => val!.isEmpty ? "Required" : null,
      ),
      trailing: InkWell(
        child: const Icon(Icons.delete_outlined, color: Colors.red),
        onTap: () {
          // controller.removeFiled();
          setState(() {
            if (controller.list.isNotEmpty) {
              controller.fieldCount.value--;
              controller.list.removeAt(i);
              controller.removeListData(i);
            }
          });
        },
      ),
    );
  }


}
