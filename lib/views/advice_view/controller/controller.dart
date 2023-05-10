import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/models/advice_model.dart';
import 'package:collage_finder/utils/constaints.dart';
import 'package:get/get.dart';

class AdviceController extends GetxController {

  final adviceList = <AdviceModel>[];
  var isAdvicesLoading = false.obs;

  @override
  void onInit() {
    getAdvices();
    super.onInit();
  }

  void getAdvices() async {
    isAdvicesLoading(true);
    adviceList.clear();
    QuerySnapshot querySnapshot = await ADVICE_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['advices'] as List<dynamic>;
    printInfo(info: 'advices=>${collages['advices']}');
    for (var element in list) {
      adviceList.add(AdviceModel(
          id: element['id'],
          adviceTitle: element['advice_title'],
          adviceContent: element['advice_content']));
    }
    isAdvicesLoading(false);
  }



}
