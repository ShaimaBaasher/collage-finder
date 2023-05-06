import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {

  final form = GlobalKey<FormState>();

  final int index = -1;

  List<Map<String, dynamic>> items = [];

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
  }

  @override
  void dispose() {
    super.dispose();
  }
}
