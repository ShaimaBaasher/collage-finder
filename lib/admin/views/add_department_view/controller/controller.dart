import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../models/department_model.dart';
import '../../../../utils/constaints.dart';

class AddDepartmentController extends GetxController {
  var isLoading = false.obs;

  var selectedChipItemIndex = 0;
  var isSwitched = false.obs;

  final departmentList = <DepartmentModel>[];

  List<int> list = [];

  List<Map<String, dynamic>> items = [];
  var fieldCount = 0.obs;
  var remainingCollagesCount = 35.obs;

  Future getDepartments() async {
    departmentList.clear();
    QuerySnapshot querySnapshot = await DEPARTMENT_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['departments'] as List<dynamic>;
    for (var element in list) {
      departmentList.add(DepartmentModel(
          departmentId: element['department_Id'],
          departmentNameEn: element['department_name_en'],
          departmentNameAr: element['department_name_ar']));
    }

    print(departmentModelListToJson(departmentList));
  }

  @override
  void onInit() async {
    await getDepartments();
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

  void removeListData(int i) {
    if (items.isNotEmpty) {
      final collageNameEn = items[i]['itinerary'] as String;
      // printInfo(info: 'collageNameEn>>${collageNameEn.split('/')[1]}');
      items.removeAt(i);
      update();
    }
  }

  void goToGenerateFormTable() {
    var rateId = departmentList[departmentList.length - 1].departmentId!;
    for (var rateMode in items) {
      rateId++;
      departmentList.add(DepartmentModel(departmentId: rateId, departmentNameEn: rateMode['itinerary'].trim()));
    }

    DEPARTMENT_REF.doc('xe1bfTthtjDRPWFsACDr').set(
        DepartmentList(list: departmentList).toJson()
    )    .then((_) => EasyLoading.showSuccess('Department Added Successfully'))
        .catchError((error) => EasyLoading.showError('Department Add failed $error'));

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
