import 'package:collage_finder/views/collage_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/collage_model.dart';
import '../../../utils/routes/app_pages.dart';
import '../../form_table_view/contoller/controller.dart';
import '../../rate_view/controller/controller.dart';

class FormController extends GetxController {
  final form = GlobalKey<FormState>();

  List<int> list = [];

  List<Map<String, dynamic>> items = [];
  var fieldCount = 0.obs;
  var remainingCollagesCount = 50.obs;

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


  @override
  void dispose() {
    super.dispose();
  }

  void removeListData(int i) {
    if (items.isNotEmpty) {
      final rateController = Get.find<RateController>();
      final collageController = Get.find<CollageController>();
      final collageNameEn = items[i]['itinerary'] as String;
      // printInfo(info: 'collageNameEn>>${collageNameEn.split('/')[1]}');
      rateController.filterList.firstWhereOrNull((element) => '${element.universityModel?.universityNameEn}/${element.collageModel?.collageNameEn}' == items[i]['itinerary'])?.isSaved = false;
      if (collageNameEn.contains('/')) {
        collageController.universityModel!.internalCollageList!.firstWhereOrNull((element) => '${element.collageNameEn}' == collageNameEn.split('/')[1])?.isSaved = false;
      }
      collageController.removeFromSavedListCollageController(collageNameEn);
      collageController.updateCollageController();
      rateController.updateRateController();
      items.removeAt(i);
      update();
    }
  }

  void goToGenerateFormTable() {
    final controller = Get.find<FormTableController>();
    controller.items = items;
    Get.toNamed(Routes.formview,);
  }

  void addTextFormField() {
    if (fieldCount.value < 50) {
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
