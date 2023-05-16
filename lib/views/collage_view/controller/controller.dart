import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/models/area_model.dart';
import 'package:collage_finder/models/collage_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../models/admission_model.dart';
import '../../../models/save_uni_model.dart';
import '../../../models/total_model.dart';
import '../../../models/university_admission_model.dart';
import '../../../models/university_model.dart';
import '../../../utils/constaints.dart';
import '../../../utils/routes/app_pages.dart';
import '../../../utils/storage/storage_service.dart';
import '../../form_view/controller/controller.dart';

class CollageController extends GetxController {

  final universityList = <UniversityModel>[];
  final filterList = <UniversityModel>[];
  final collageList = <CollageModel>[];
  final areaList = <AreaModel>[];
  final saveUniversityList = <SavedUniModel>[];
  final admissionList = <AdmissionModel>[];
  final universityAdmissionList = <UniversityAdmissionModel>[];
  final rateList = <TotalModel>[];
  final rateValueList = <TotalModel>[];

  var searchBox = '';
  var savedUniversityIndex = -1;

  var isUniversityLoading = false.obs;
  var isCollagesLoading = false.obs;

  UniversityModel? universityModel;

  AreaModel? areaModel;

  @override
  void onInit() async {
    await getAreas();
    await getUniversities();
    super.onInit();
  }

  Future getUniversities() async {
    isUniversityLoading(true);
    universityList.clear();
    QuerySnapshot querySnapshot = await UNIVERSITIES_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    final list = universities['universities'] as List<dynamic>;
    printInfo(info: 'universities>>${universities['universities']}');

    for (var element in list) {
      final imgList = <Images>[];
      final cList = <int>[];

      final list = element['images'] as List<dynamic>;
      final colist = element['collages'] as List<dynamic>;

      for (var imgElement in list) {
        imgList.add(Images(imageUrl: imgElement["imageUrl"]));
      }

      for (var cElement in colist) {
        cList.add(cElement);
      }

      for (var areaElement in areaList) {
        if (element['area_id'] == areaElement.areaId) {
          areaModel = AreaModel(
              areaId: areaElement.areaId, areaName: areaElement.areaName);
        }
      }

      universityList.add(UniversityModel(
          img: element['img'],
          images: imgList,
          collages: cList,
          about: element['about'],
          areaModel: areaModel,
          universityId: element['university_Id'],
          areaId: element['area_id'],
          universityNameEn: element['university_name_en'],
          universityNameAr: element['university_name_ar']));
    }

    filterList.clear();
    filterList.addAll(universityList);
    isUniversityLoading(false);
  }

  Future getRates() async {
    rateList.clear();
    QuerySnapshot querySnapshot = await RATE_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['rates'] as List<dynamic>;
    for (var element in list) {
      rateList.add(TotalModel(totalId: element['rate_Id'], total: element['rate']));
    }
    print(allData[0]);
  }

  Future getAdmission() async {
    admissionList.clear();
    QuerySnapshot querySnapshot = await ADMISSION_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    final list = universities['admission-rate'] as List<dynamic>;

    printInfo(info: 'admission-rate>${universities['admission-rate']}');

    for (var element in list) {
      admissionList.add(AdmissionModel(
        sectorId: element['sector_Id'],
        categoryId: element['category_Id'],
        collageId: element['collage_Id'],
        departmentId: element['department_Id'],
        rateId: element['rate_Id'],
        superlativeId: element['superlative_Id'],
        totalId: element['total_Id'],
        universityId: element['university_Id'],
      ));
    }

    // if rateId == admissionList.id and admissionList.unId == universityId and collageId == admissionList.collageId
    if (collageList.isNotEmpty) {
      for (var collageModel in collageList) {
        var rateId = admissionList.firstWhereOrNull((element) => element.collageId == collageModel.collageId && element.universityId == universityModel?.universityId)?.rateId;
        rateId != null ? collageModel.rate = rateList.firstWhereOrNull((element) => element.totalId == rateId)?.total : null;
      }
    }
  }

  Future getCollages() async {
    // isUniversityLoading(true);
    final innerCollageList = <CollageModel>[];

    QuerySnapshot querySnapshot = await COLLAGES_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    for (var element in universities['collages']) {
      innerCollageList.add(CollageModel(
        collageId: element['collage_Id'],
        collageNameEn: element['collage_name_en'],
        collageNameAr: element['collage_name_ar'],
      ));
    }

    collageList.clear();
    universityModel!.internalCollageList?.clear();

    if (universityModel!.collages != null) {
      for (var collage in universityModel!.collages!) {
        var model = innerCollageList.firstWhere((element) => element.collageId == collage);
        collageList.add(CollageModel(
            collageId: model.collageId,
            collageNameEn: model.collageNameEn,
            isSaved: false));
      }
    }


    checkIfCollageIsInLocalStorage();

    await getRates();
    await getAdmission();

    this.universityModel!.internalCollageList = collageList;
  }

  Future getAreas() async {
    // isUniversityLoading(true);
    areaList.clear();
    QuerySnapshot querySnapshot = await AREA_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    final list = universities['areas'] as List<dynamic>;
    printInfo(info: 'areas>>${universities['areas']}');
    for (var element in list) {
      areaList.add(AreaModel(areaId: element['area_Id'], areaName: element['area_name'],));
    }
    printInfo(info: 'areas>>${areaModelListToJson(areaList!)}');
  }

  void filter() {
    final List<UniversityModel> tripList = [];
    if (searchBox.isNotEmpty) {
      for (var item in universityList) {
        if (searchBox
            .toLowerCase()
            .contains(item.universityNameEn!.toLowerCase())) {
          tripList.add(item);
        }
      }
      filterList.clear();
      filterList.addAll(tripList);
    } else {
      filterList.clear();
      filterList.addAll(universityList);
    }

    update();
  }

  void openUniversityDetails(UniversityModel universityModel) async {
    isCollagesLoading(true);
    this.universityModel = universityModel;
    Get.toNamed(Routes.universityDetailsView,);
    await getCollages();
    isCollagesLoading(false);
  }

  void checkIfCollageIsInLocalStorage() async {
    final list = await getSavedUniList();
    if (list!.isNotEmpty) {
      await getSavedCollagesFromStorage(list);
    }
  }

  Future getSavedCollagesFromStorage(List<SavedUniModel> list,) async {
    saveUniversityList.clear();
    saveUniversityList.addAll(list);
    for (var i = 0; i < saveUniversityList.length; i++) {
      for (var k = 0; k < collageList.length; k++) {
        if (saveUniversityList[i].un_Id == universityModel!.universityId && saveUniversityList[i].cat_Id == collageList[k].collageId) {
          collageList[k].isSaved = true;
        }
      }
    }
    update();
  }

  Future<bool> checkIfAlreadyExistDontAddUniversityElseAdd(CollageModel collageModel) async {
    var isAlreadyExist = false;
    if (saveUniversityList.isNotEmpty) {
      for (var i = 0; i < saveUniversityList.length; i++) {
          if (saveUniversityList[i].un_Id == universityModel!.universityId && saveUniversityList[i].cat_Id == collageModel.collageId) {
              isAlreadyExist = true;
          }
      }
    } else {
      isAlreadyExist = false;
    }

    if (!isAlreadyExist) {
      saveUniversityList.add(SavedUniModel(uniCollageName: '${universityModel!.universityNameEn}/${collageModel.collageNameEn}' ,un_Id: universityModel!.universityId, cat_Id: collageModel.collageId));
      StorageService.to.setUniversityList(saveUniversityList);
    }

    return isAlreadyExist;
  }

  void removeCollage() async {
    if (saveUniversityList.isNotEmpty) {
      for (var i = 0; i < saveUniversityList.length; i++) {
        for (var k = 0; k < collageList.length; k++) {
          if (saveUniversityList[i].un_Id == universityModel!.universityId && saveUniversityList[i].cat_Id == collageList[k].collageId) {
            saveUniversityList.removeAt(i);
            StorageService.to.setUniversityList(saveUniversityList!);
            return;
          }
        }
      }
    }
  }

  Future<List<SavedUniModel>?> getSavedUniList() {
    return StorageService.to.getUniversityList();
  }

  void saveUniversityForm(int index, CollageModel collageModel) async {
    final formController = Get.find<FormController>();
    savedUniversityIndex = index;
    collageModel.isSaved = true;
    formController.addTextFormField();
    formController.storeValue(formController.list.length - 1, '${universityModel!.universityNameEn!}/${collageModel.collageNameEn}');
    savedUniversityIndex = -1;
    printInfo(info: 'collageModel>>${collagesModelToJson(collageModel)}');
    update();
    if (await checkIfAlreadyExistDontAddUniversityElseAdd(collageModel)) {
      EasyLoading.showError('Collage Already Exist');
    } else {
      StorageService.to.setUniversityList(saveUniversityList!);
    }
  }

  void removeUniversityForm(int index, CollageModel collageModel) {
    final formController = Get.find<FormController>();
    savedUniversityIndex = index;
    collageModel.isSaved = false;
    if (formController.list.isNotEmpty) {
      formController.removeTextFormField(formController.list.length - 1);
    }
    savedUniversityIndex = -1;
    update();
    removeCollage();
  }

  void removeFromSavedListCollageController(String uniCollageName) async {
    final list = await getSavedUniList();
    if (list!.isNotEmpty) {
      saveUniversityList.clear();
      saveUniversityList.addAll(list);
        for (var i = 0; i < saveUniversityList.length; i++) {
          for (var k = 0; k < collageList.length; k++) {
            if (saveUniversityList[i].uniCollageName == uniCollageName) {
              saveUniversityList.removeAt(i);
              StorageService.to.setUniversityList(saveUniversityList);
              return;
            }
          }
        }
    }
  }

  @override
  void dispose() {
    universityModel!.internalCollageList?.clear();
    super.dispose();
  }
  void updateCollageController() {
    savedUniversityIndex = -1;
    update();
  }
}
