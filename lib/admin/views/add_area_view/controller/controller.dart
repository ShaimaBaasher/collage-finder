import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/models/area_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../utils/constaints.dart';

class AddAreaController extends GetxController {
  var isLoading = false.obs;

  var selectedChipItemIndex = 0;
  var isSwitched = false.obs;

  final areaList = <AreaModel>[];

  List<int> list = [];

  List<Map<String, dynamic>> items = [];
  var fieldCount = 0.obs;
  var remainingCollagesCount = 35.obs;

  Future getAreas() async {
    areaList.clear();
    QuerySnapshot querySnapshot = await AREA_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    final list = universities['areas'] as List<dynamic>;
    for (var element in list) {
      areaList.add(AreaModel(
        areaId: element['area_Id'],
        areaName: element['area_name'],
      ));
    }
  }

  @override
  void onInit() async {
    await getAreas();
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
      areaList.removeAt(i);
      items.removeAt(i);
      update();
    }
  }

  void goToGenerateFormTable() {
    var rateId = areaList.isNotEmpty ? areaList[areaList.length - 1].areaId! : 1;
    for (var rateMode in items) {
      rateId++;
      areaList.add(
          AreaModel(areaId: rateId, areaName: rateMode['itinerary'].trim()));
    }

    AREA_REF
        .doc('aKnXir441oVW6bQGpIbu')
        .set(AreaList(list: areaList).toJson())
     .then((_) => EasyLoading.showSuccess('Area Added Successfully'))
        .catchError((error) => EasyLoading.showError('Area Add failed $error'));
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
