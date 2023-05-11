import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../models/department_model.dart';
import '../../../../models/filter_model.dart';
import '../../../../utils/constaints.dart';

class AddDepartmentController extends GetxController {
  var isLoading = false.obs;

  var selectedChipItemIndex = 0;
  var isSwitched = false.obs;

  final departmentList = <DepartmentModel>[];
  final selectedGenderList = <FilterModel>[];

  List<int> list = [];

  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> genderItems = [];

  var fieldCount = 0.obs;
  var remainingCollagesCount = 35.obs;

  final genderList = [
    FilterModel(filterId: 10, filterName: 'Male And Female', dbId: 1),
    FilterModel(filterId: 8, filterName: 'Male only', dbId: 3),
    FilterModel(filterId: 9, filterName: 'Female only', dbId: 2),
  ];

  Future getDepartments() async {
    departmentList.clear();
    QuerySnapshot querySnapshot = await DEPARTMENT_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['departments'] as List<dynamic>;
    for (var element in list) {
      departmentList.add(DepartmentModel(
          genderId: element['gender_Id'],
          departmentId: element['department_Id'],
          departmentNameEn: element['department_name_en'],
          departmentNameAr: element['department_name_ar']));
    }
  }

  @override
  void onInit() async {
    super.onInit();
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

    items.add({
      "field_id": i,
      "itinerary": v,
    });

    update();
  }

  dynamic storeGenderValue(int i, FilterModel v) {
    bool valueFound = false;
    for (int j = 0; j < genderItems.length; j++) {
      if (genderItems[j].containsKey("field_id")) {
        if (genderItems[j]["field_id"] == i) {
          valueFound = !valueFound;
          break;
        }
      }
    }

    /// If value is found
    if (valueFound) {
      genderItems.removeWhere((e) => e["field_id"] == i);
    }

    genderItems.add({
      "field_id": i,
      "itinerary": v.dbId,
    });
    selectedGenderList.add(v);
    update();
  }

  void removeListData(int i) {
    if (items.isNotEmpty) {
      items.removeAt(i);
      genderItems.removeAt(i);
      selectedGenderList.removeAt(i);

      update();
    }
  }

  void goToGenerateFormTable(BuildContext context) async {
    await getDepartments();

    if (selectedGenderList.length == items.length) {
      var rateId = departmentList.isNotEmpty ? departmentList[departmentList.length - 1].departmentId! : 1;
      // for (var rateMode in items) {
      // }

      for (int i = 0; i < selectedGenderList.length; i++) {
        rateId++;
        departmentList.add(DepartmentModel(departmentId: rateId, genderId: selectedGenderList[i].dbId, departmentNameEn: items[i]['itinerary'].trim()));
        printInfo(info: '${departmentList[i].genderId} = ${selectedGenderList[i].dbId}');
      }

      DEPARTMENT_REF.doc('xe1bfTthtjDRPWFsACDr').set(
          DepartmentList(list: departmentList).toJson()
      )    .then((_) => EasyLoading.showSuccess('Department Added Successfully'))
          .catchError((error) => EasyLoading.showError('Department Add failed $error'));
      Navigator.pop(context);
    } else {
      EasyLoading.showError('Fields missing');
    }
  }

  void addTextFormField() {
    if (fieldCount.value <= 35) {
      fieldCount.value++;
      remainingCollagesCount.value--;
      list.add(fieldCount.value);
    }
    update();
  }

  void removeTextFormField(int i) {
    if (list.isNotEmpty) {
      fieldCount.value--;
      remainingCollagesCount.value++;
      list.removeAt(i);
      removeListData(i);
    }
  }
}
