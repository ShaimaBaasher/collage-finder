import 'package:collage_finder/admin/views/add_university/controller/controller.dart';
import 'package:collage_finder/models/collage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io' as io;

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/area_model.dart';
import '../../../../utils/storage/storage_service.dart';
import '../../../../utils/styles.dart';
import '../../../../widgets/loading_widget.dart';

enum Gender { male, female, all }

class AddUniversityView extends StatelessWidget {
  AddUniversityView({Key? key}) : super(key: key);
  final controller = Get.find<AddUniversityController>();
  final form = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text("Add University Info"),
        actions: [
          Obx(() => IconButton(
              onPressed: controller.isInsertingLoading.isTrue
                  ? null
                  : () {
                      if (!_formKey.currentState!.validate() &&
                          form.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Fields missing")));
                      } else {
                        // TODO Create Table View Form
                        controller.uploadUniversity();
                      }
                    },
              icon: const Icon(Icons.add)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () async {
                  await controller.pickImage();
                },
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child:
                      GetBuilder<AddUniversityController>(builder: (context) {
                    return Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        controller.isImagePulledFromStorage
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  io.File(controller.imagePath),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ))
                            : StorageService.to.universityPhotoUrl == null ||
                                    StorageService
                                        .to.universityPhotoUrl!.isEmpty
                                ? const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.indigo,
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: Colors.white,
                                    ))
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '${StorageService.to.universityPhotoUrl}'),
                                    radius: 30,
                                  ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  Container(
                    width: 19.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                      ),
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      color: Colors.white,
                      onPressed: () {
                        controller.selectImages();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 0.5.w,
                  ),
                  GetBuilder<AddUniversityController>(builder: (_) {
                    return SizedBox(
                      height: 12.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.imageFileList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(
                                    io.File(
                                        controller.imageFileList![index].path),
                                    height: 5.h,
                                    width: 19.w,
                                    fit: BoxFit.cover,
                                  )),
                            );
                          }),
                    );
                  }),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                height: 1.h,
              ),
              Form(
                key: form,
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.9,
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
                            hintText: "Enter University Name",
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
                          controller.universityName = value;
                        },
                        onFieldSubmitted: (_) {},
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
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
                            hintText: "Add About University",
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
                          controller.aboutUniversity = value;
                        },
                        onFieldSubmitted: (_) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Obx(
                () => controller.isAreaLoading.isTrue
                    ? const LoadingWidget()
                    : GetBuilder<AddUniversityController>(builder: (_) {
                        return DropdownButton<AreaModel>(
                          dropdownColor: Colors.black87,
                          //<-- SEE HERE
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.indigo, // <-- SEE HERE
                          ),
                          value: controller.dropdownValue,
                          items: controller.areaList
                              .map<DropdownMenuItem<AreaModel>>(
                                  (value) => DropdownMenuItem<AreaModel>(
                                        value: value,
                                        child: FittedBox(
                                          child: Text(
                                            '${value.areaName}',
                                            style: kLabelPrimaryNormalTextStyle
                                                .copyWith(
                                                    fontSize: 17.sp,
                                                    color: Colors.indigo),
                                          ),
                                        ),
                                      ))
                              .toList(),
                          onChanged: (newValue) {
                            controller.changeDropdownValue(newValue!);
                          },
                        );
                      }),
              ),
              SizedBox(
                height: 1.h,
              ),
              GetBuilder<AddUniversityController>(builder: (_) {
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        horizontalTitleGap: 2,
                        title: Text(
                          'Male',
                          style: kLabelPrimaryNormalTextStyle,
                        ),
                        leading: Radio<Gender>(
                          activeColor: kPurpleColor,
                          value: Gender.male,
                          groupValue: controller.genderOption,
                          onChanged: (Gender? value) {
                            controller.genderOption = value;
                            controller
                                .setSelectedGender(controller.genderOption!);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        horizontalTitleGap: 2,
                        title: Text(
                          'Female',
                          style: kLabelPrimaryNormalTextStyle,
                        ),
                        leading: Radio<Gender>(
                          activeColor: kPurpleColor,
                          value: Gender.female,
                          groupValue: controller.genderOption,
                          onChanged: (Gender? value) {
                            controller.genderOption = value;
                            controller
                                .setSelectedGender(controller.genderOption!);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        horizontalTitleGap: 2,
                        title: Text(
                          'All',
                          style: kLabelPrimaryNormalTextStyle,
                        ),
                        leading: Radio<Gender>(
                          activeColor: kPurpleColor,
                          value: Gender.all,
                          groupValue: controller.genderOption,
                          onChanged: (Gender? value) {
                            controller.genderOption = value;
                            controller
                                .setSelectedGender(controller.genderOption!);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 1.h,
              ),
              Obx(
                () => controller.fieldCount.value == 0
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "No Collages added !",
                            style: kLabelSecondryTextStyle.copyWith(
                                fontSize: 18.sp),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          GetBuilder<AddUniversityController>(builder: (_) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.list.length,
                              itemBuilder: (_, i) => buildsField(i),
                            );
                          }),
                          const SizedBox(height: 12),
                        ],
                      ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                onPressed: () {
                  controller.addTextFormField();
                },
                icon: Icon(Icons.add),
                label: const Text("Add Collage"),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildsField(int i) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.indigo,
        child: Text((i + 1).toString()),
      ),
      title: Autocomplete(
        key: Key(controller.list[i].toString()),
        // <- Magic!
        initialValue: TextEditingValue(
          text: controller.items.length > i
              ? controller.items[i]["itinerary"]
              : '',
        ),
        displayStringForOption: (CollageModel option) => option.collageNameEn!,
        onSelected: (CollageModel selection) {
          controller.storeValue(i, selection);
        },
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<CollageModel>.empty();
          }
          return controller.collageList.where((CollageModel model) {
            return model.collageNameEn!
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
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
