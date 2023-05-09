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

  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<FormController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: const Text("Virtual Application Form"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,),
                  Text(
                    'application_for_colleges_and_institutes'.tr,
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryTextStyle.copyWith(fontSize: 19.sp),),
                  SizedBox(height: 2.h),
                  Obx(
                    () => controller.fieldCount.value == 0 ? Padding(
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
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'You still need to add ${controller.remainingCollagesCount.value} Collages, Collages Added ${controller.fieldCount.value}',
                                  textAlign: TextAlign.start,
                                  style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 18.sp),
                                ),
                              ),
                              GetBuilder<FormController>(builder: (_) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.list.length,
                                  itemBuilder: (_, i) => buildField(i),
                                );
                              }),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo,),
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
          backgroundColor: Colors.indigo,
          child: const Text("ADD\nNEW"),
          onPressed: () {
            controller.addTextFormField();
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
            content: const Text(
                'Would you like to generate your selected Colleges ? '),
            actions: [
              TextButton(
                // FlatButton widget is used to make a text to work like a button
                onPressed: () {
                  Navigator.pop(context);
                }, // function used to perform after pressing the button
                child: const Text('Cancel'),
              ),
              TextButton(
                // FlatButton widget is used to make a text to work like a button
                onPressed: () {
                  controller.goToGenerateFormTable();
                  // Navigator.pop(context);
                }, // function used to perform after pressing the button
                child: const Text('Generate'),
              ),
            ],
          );
        });
  }

  Widget buildField(int i) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.indigo,
        child: Text((i + 1).toString()),
      ),
      title: TextFormField(
        key: Key(controller.list[i].toString()), // <- Magic!
        initialValue: controller.items.length > i ? controller.items[i]["itinerary"]
            : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          labelText: "${'college_or_institute'.tr} ${i + 1}",
        ),
        onChanged: (data) => controller.storeValue(i, data),
        validator: (val) => val!.isEmpty ? "Required" : null,
      ),
      trailing: InkWell(
        child: const Icon(Icons.delete_outlined, color: Colors.red),
        onTap: () {
          controller.removeTextFormField(i);
        },
      ),
    );
  }
}
