import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/routes/app_pages.dart';
import '../../form_table_view/contoller/controller.dart';

class FormController extends GetxController {
  final form = GlobalKey<FormState>();

  List<int> list = [];

  List<Map<String, dynamic>> items = [];
  var fieldCount = 0.obs;

  @override
  void onInit() {
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

    items.add({"field_id": i, "itinerary": v,});
    update();
  }

  void storeValueFromRateController(int i, String v) {
    items.add({"field_id": i, "itinerary": v,});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void removeListData(int i) {
    if (items.isNotEmpty) {
      items.removeAt(i);
    }
  }

  void goToGenerateFormTable() {
    final controller = Get.find<FormTableController>();
    controller.items = items;
    Get.toNamed(
      Routes.formview,
    );
  }

  void addTextFormField() {
    if (fieldCount.value <= 35) {
      fieldCount.value++;
      list.add(fieldCount.value);
    }
    update();
  }

  void removeTextFormField(int i) {
    if (list.isNotEmpty) {
      fieldCount.value--;
      list.removeAt(i);
      removeListData(i);
    }
  }
}
