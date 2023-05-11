
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../models/advice_model.dart';
import '../../../../utils/constaints.dart';

class AddAdviceController extends GetxController {

  String question  = '';
  String answer  = '';

  final adviceList = <AdviceModel>[];
  var isAdvicesLoading = false.obs;
  var isInsertingLoading = false.obs;

  @override
  void onInit() async {
    await getAdvices();
    super.onInit();
  }

  Future getAdvices() async {
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

  void uploadAdvice() async {
    isInsertingLoading(true);
    // Images
    await getAdvices();

    adviceList.add(AdviceModel(
        id: adviceList.isNotEmpty ? adviceList[adviceList.length -1].id! + 1 : 1,
        adviceTitle: question,
        adviceContent: answer));

    ADVICE_REF.doc('Y75liFOlf5awkOQJwIEl').set(
        AdviceList(list: adviceList).toJson()
      // 'universities': input
    )        .then((_) => EasyLoading.showSuccess('Advice Added Successfully'))
        .catchError((error) => EasyLoading.showError('Advice Add failed $error'));
    isInsertingLoading(false);
  }


}