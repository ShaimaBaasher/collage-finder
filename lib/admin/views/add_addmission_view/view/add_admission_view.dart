import 'package:collage_finder/admin/views/add_addmission_view/controller/add_admission_contoller.dart';
import 'package:collage_finder/models/category_model.dart';
import 'package:collage_finder/models/department_model.dart';
import 'package:collage_finder/models/rate_model.dart';
import 'package:collage_finder/models/university_model.dart';
import 'package:collage_finder/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/collage_model.dart';
import '../../../../utils/styles.dart';

class AddAdmissionView extends StatelessWidget {
   AddAdmissionView({Key? key}) : super(key: key);

   final controller = Get.find<AddAdmissionController>();

   @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            centerTitle: true,
            title: const Text("Add Admission Rate to University"),
          ),
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2.h,),
              Obx(() => controller.isLoading.isTrue ?
              const LoadingWidget() :
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'University Name',
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 18.sp),),
                  Autocomplete<UniversityModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<UniversityModel>.empty();
                      }
                      return controller.universityModelLists.where((UniversityModel model) {
                        return model.universityNameEn!.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    displayStringForOption: (UniversityModel option) => option.universityNameEn!,
                    onSelected: (UniversityModel selection) {
                      controller.universityModel = selection;
                    },
                  ),
                  SizedBox(height: 2.h,),
                  Text(
                    'Collage Name',
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 18.sp),),
                  Autocomplete<CollageModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<CollageModel>.empty();
                      }
                      return controller.collageList.where((CollageModel model) {
                        return model.collageNameEn!.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    displayStringForOption: (CollageModel option) => option.collageNameEn!,
                    onSelected: (CollageModel selection) {
                      controller.collageModel = selection;
                    },
                  ),
                  SizedBox(height: 2.h,),
                  Text(
                    'Department Name',
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 18.sp),),
                  Autocomplete<DepartmentModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<DepartmentModel>.empty();
                      }
                      return controller.departmentList.where((DepartmentModel model) {
                        return model.departmentNameEn!.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    displayStringForOption: (DepartmentModel option) => option.departmentNameEn!,
                    onSelected: (DepartmentModel selection) {
                      controller.departmentModel = selection;
                      debugPrint('You just selected ${selection.departmentId}');
                    },
                  ),
                  SizedBox(height: 2.h,),
                  Text(
                    'Category Name',
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 18.sp),),
                  Autocomplete<CategoryModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<CategoryModel>.empty();
                      }
                      return controller.categoryList.where((CategoryModel model) {
                        return model.categoryNameEn!.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    displayStringForOption: (CategoryModel option) => option.categoryNameEn!,
                    onSelected: (CategoryModel selection) {
                      controller.categoryModel = selection;
                      debugPrint('You just selected $selection');
                    },
                  ),
                  SizedBox(height: 2.h,),
                  Text(
                    'Admission Rate',
                    textAlign: TextAlign.start,
                    style: kLabelPrimaryNormalTextStyle.copyWith(fontSize: 18.sp),),
                  Autocomplete<RateModel>(

                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<RateModel>.empty();
                      }
                      return controller.rateStringList.where((RateModel model) {
                        return (model.rate.toString()).contains(textEditingValue.text);
                      });
                    },
                    displayStringForOption: (RateModel option) => option.rate!,
                    onSelected: (RateModel selection) {
                      controller.rateModel = selection;

                      debugPrint('You just selected $selection');
                    },
                  ),
                  Obx(() =>
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,),
                        onPressed: controller.isInsertingLoading.isTrue ? null : () {
                          controller.uploadAdmission();
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add Admission Rate"),),
                  ),

                ],
              )
              )
            ],
          ),
        ),
      ),
    ));
  }
}
