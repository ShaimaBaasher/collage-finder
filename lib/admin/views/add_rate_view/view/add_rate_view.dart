import 'package:collage_finder/admin/views/add_rate_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/styles.dart';

class AddRateView extends StatelessWidget {
   AddRateView({Key? key}) : super(key: key);

   final _formKey = GlobalKey<FormState>();
   final controller = Get.find<AddRateController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
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
                    'Add Rate',
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryTextStyle.copyWith(fontSize: 19.sp),),
                  SizedBox(height: 2.h),
                  Obx(
                        () => controller.fieldCount.value == 0 ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "No Rates added !",
                          style: kLabelSecondryTextStyle.copyWith(
                              fontSize: 18.sp),
                        ),
                      ),
                    )
                        : Column(
                      children: [

                        GetBuilder<AddRateController>(builder: (_) {
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
             title: const Text("Upload Rates"),
             content: const Text('Would you like to Upload Rates ? '),
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
                   Navigator.pop(context);
                 }, // function used to perform after pressing the button
                 child: const Text('Upload'),
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
        keyboardType: TextInputType.number,
        key: Key(controller.list[i].toString()), // <- Magic!
        initialValue: controller.items.length > i ? controller.items[i]["itinerary"]
            : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          labelText: "Rate Value ${i + 1}",
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
