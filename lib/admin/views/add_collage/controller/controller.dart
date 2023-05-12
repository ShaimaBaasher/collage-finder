import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/models/collage_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../utils/constaints.dart';

class AddCollageController extends GetxController {
  var isLoading = false.obs;

  var selectedChipItemIndex = 0;
  var isSwitched = false.obs;

  final collageList = <CollageModel>[];

  List<int> list = [];

  List<Map<String, dynamic>> items = [];
  var fieldCount = 0.obs;
  var remainingCollagesCount = 35.obs;

  Future getCollages() async {
    collageList.clear();
    QuerySnapshot querySnapshot = await COLLAGES_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['collages'] as List<dynamic>;
    for (var element in list) {
      collageList.add(CollageModel(
          collageId: element['collage_Id'],
          collageNameEn: element['collage_name_en'],
          collageNameAr: element['collage_name_ar']));
    }
  }

  @override
  void onInit() async {
    await getCollages();
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
      collageList.removeAt(i);
      update();
    }
  }

  void goToGenerateFormTable() async {
    await getCollages();
    var rateId = collageList.isNotEmpty ? collageList[collageList.length - 1].collageId! : 1;
    for (var rateMode in items) {
      rateId++;
      collageList.add(CollageModel(collageId: rateId, collageNameEn: rateMode['itinerary'].trim()));
    }

    EasyLoading.show(status: 'Loading Please wait');

    COLLAGES_REF.doc('PjipJ1Z7wmTS7wFvWFa4').set(
        CollageList(list: collageList).toJson()
    )    .then((_) => EasyLoading.showSuccess('College Added Successfully'))
        .catchError((error) => EasyLoading.showError('College Add failed $error'));

    clearFields();
  }

  void addTextFormField() {
      fieldCount.value++;
      remainingCollagesCount.value--;
      list.add(fieldCount.value);
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

  void clearFields() {
    fieldCount(0);
    items.clear();
    list.clear();
    update();
  }

}
