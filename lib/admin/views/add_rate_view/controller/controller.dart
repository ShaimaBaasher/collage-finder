import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/models/rate_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../models/total_model.dart';
import '../../../../utils/constaints.dart';

class AddRateController extends GetxController {
  var isLoading = false.obs;

  var selectedChipItemIndex = 0;
  var isSwitched = false.obs;

  final rateList = <RateModel>[];

  List<int> list = [];

  List<Map<String, dynamic>> items = [];
  var fieldCount = 0.obs;
  var remainingCollagesCount = 35.obs;

  Future getRates() async {
    rateList.clear();
    QuerySnapshot querySnapshot = await RATE_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['rates'] as List<dynamic>;
    for (var element in list) {
      rateList
          .add(RateModel(rateId: element['rate_Id'], rate: element['rate']));
    }
  }

  @override
  void onInit() async {
    await getRates();
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
      rateList.removeAt(i);
      items.removeAt(i);
      update();
    }
  }

  void goToGenerateFormTable() {
    var rateId = rateList[rateList.length - 1].rateId!;
    for (var rateMode in items) {
      rateId++;
      rateList.add(RateModel(rateId: rateId, rate: double.tryParse(rateMode['itinerary'].trim())));
    }

    RATE_REF.doc('sKzRIxcYmTeymrptKUzG').set(
        RateList(rateModel: rateList).toJson()
      // 'universities': input
    )    .then((_) => EasyLoading.showSuccess('Rate Added Successfully'))
        .catchError((error) => EasyLoading.showError('Rate Add failed $error'));

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
