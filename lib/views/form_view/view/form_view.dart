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
  List<Widget> list = [];
  int fieldCount = 0;

  List<Map<String, dynamic>> items = [];

  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<FormController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo, centerTitle: true, title: const Text("Form"),),
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
                    style: kLabelPrimaryTextStyle.copyWith(fontSize: 19.sp),
                  ),
                  SizedBox(height: 2.h),
                  fieldCount == 0
                      ?  Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "No Colleges and Institutes added!",
                              style: kLabelSecondryTextStyle.copyWith(fontSize: 18.sp),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (_, i) => buildField(i),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Fields missing")));
                                  } else {
                                    // TODO Create Table View Form
                                    itinerariesDialog(context);
                                  }
                                },
                                child: const Text("Validate")),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Text("ADD\nNEW"),
          onPressed: () {
            setState(() {
              if (fieldCount <= 25) {
                fieldCount++;
                list.add(buildField(fieldCount));
              }
            });
          },
        ),
      ),
    );
  }

  itinerariesDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Stored Colleges and Institutes"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: items.map((e) => Text(e["itinerary"].trim())).toList(),
              ),
            ),
          );
        });
  }

  Widget buildField(int i) {
    return ListTile(
      leading: CircleAvatar(
        child: Text((i + 1).toString()),
      ),
      title: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          labelText: "${'college_or_institute'.tr} ${i + 1}",
        ),
        onChanged: (data) => storeValue(i + 1, data),
        validator: (val) => val!.isEmpty ? "Required" : null,
      ),
      trailing: InkWell(
        child: const Icon(Icons.delete_outlined, color: Colors.red),
        onTap: () {
          setState(() {
            if (list.isNotEmpty) {
              fieldCount--;
              list.removeAt(i);
              if (items.isNotEmpty) {
                items.removeAt(i);
              }
            }
          });
        },
      ),
    );
  }

  dynamic storeValue(int i, String v) {
    bool valueFound = false;
    for (int j = 0; j < items.length; j++) {
      if (items[j].containsKey("field_id")) {
        if (items[j]["field_id"] == i) {
          valueFound = !valueFound;
          break;
        }
      }
    }
    /// If value is found
    if (valueFound) {
      items.removeWhere((e) => e["field_id"] == i);
    }
    items.add({"field_id": i, "itinerary": v,});
  }
}
