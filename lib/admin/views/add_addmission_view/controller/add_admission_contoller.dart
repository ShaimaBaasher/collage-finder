import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/models/category_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../models/admission_model.dart';
import '../../../../models/area_model.dart';
import '../../../../models/collage_model.dart';
import '../../../../models/department_model.dart';
import '../../../../models/rate_model.dart';
import '../../../../models/university_model.dart';
import '../../../../utils/constaints.dart';

class AddAdmissionController extends GetxController {

  final universityModelLists = <UniversityModel>[];
  final areaList = <AreaModel>[];
  final departmentList = <DepartmentModel>[];
  final collageList = <CollageModel>[];
  final rateList = <RateModel>[];
  final rateStringList = <RateModel>[];
  final categoryList = <CategoryModel>[];
  final admissionList = <AdmissionModel>[];

  var isLoading = false.obs;
  var isInsertingLoading = false.obs;

  CategoryModel? categoryModel;
  UniversityModel? universityModel;
  CollageModel? collageModel;
  DepartmentModel? departmentModel;
  RateModel? rateModel;

  @override
  void onInit() async {
    isLoading(true);
    await getAdmission();
    await getAreas();
    await getUniversities();
    await getDepartments();
    await getCategory();
    await getCollages();
    await getRates();
    super.onInit();
    isLoading(false);
  }

  Future getRates() async {
    rateList.clear();
    rateStringList.clear();
    QuerySnapshot querySnapshot = await RATE_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['rates'] as List<dynamic>;
    for (var element in list) {
      rateList.add(RateModel(rateId: element['rate_Id'], rate: element['rate']));
      rateStringList.add(RateModel(rateId: element['rate_Id'], rate: element['rate'].toString()));
    }
  }

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

  Future getCategory() async {
    categoryList.clear();
    QuerySnapshot querySnapshot = await CATEGORY_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    final list = universities['categories'] as List<dynamic>;
    for (var element in list) {
      categoryList.add(CategoryModel(
        categoryId: element['category_Id'],
        categoryNameEn: element['category_name_en'],
      ));
    }
  }

  Future getUniversities() async {
    AreaModel? areaModel;

    universityModelLists.clear();
    QuerySnapshot querySnapshot = await UNIVERSITIES_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    final list = universities['universities'] as List<dynamic>;
    printInfo(info: 'areaModel>>${universities['universities']}');

    for (var element in list) {
      for (var areaElement in areaList) {
        if (element['area_id'] == areaElement.areaId) {
          areaModel = AreaModel(
              areaId: areaElement.areaId, areaName: areaElement.areaName);
        }
      }

      universityModelLists.add(UniversityModel(
          img: element['img'],
          universityId: element['university_Id'],
          genderId: element['gender_Id'],
          areaId: element['area_id'],
          about: element['about'],
          areaModel: areaModel,
          universityNameEn: element['university_name_en'],
          universityNameAr: element['university_name_ar']));

      printInfo(
          info:
          'areaModel>>${universityModelListToJson(universityModelLists!)}');
    }
  }

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
  }

  void uploadAdmission() async {
    isInsertingLoading(true);
    // Images

    admissionList.add(AdmissionModel(
        totalId: 1,
        sectorId: 1,
        superlativeId: 1,
        universityId: universityModel?.universityId,
        collageId: collageModel?.collageId,
        rateId: rateModel?.rateId,
        departmentId: departmentModel?.departmentId,
        categoryId: categoryModel?.categoryId));

    ADMISSION_REF.doc('pK0we3MKnVIe6dgVJ0sT').set(
        AdmissionList(list: admissionList).toJson()
      // 'universities': input
    )        .then((_) => EasyLoading.showSuccess('Admission Added Successfully'))
        .catchError((error) => EasyLoading.showError('Admission Add failed $error'));
    isInsertingLoading(false);
  }

}