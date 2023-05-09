import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/models/area_model.dart';
import 'package:collage_finder/models/filter_model.dart';
import 'package:collage_finder/models/admission_model.dart';
import 'package:collage_finder/models/university_admission_model.dart';
import 'package:collage_finder/utils/constaints.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/src/common.dart';

import '../../../models/collage_model.dart';
import '../../../models/department_model.dart';
import '../../../models/total_model.dart';
import '../../../models/university_model.dart';
import '../../form_view/controller/controller.dart';

class RateController extends GetxController {

  final formController = Get.find<FormController>();

  var selectedDurationIndex = 0;
  var selectedUniversityCategoryIndex = 0;
  var selectedSpecialtyCategoryIndex = 0;
  var selectedGenderIndex = 0;

  var selectedSpecialtyCategoryItem = 1;
  var selectedGenderItem = 1;

  var savedUniversityIndex = -1;

  var isUniversityLoaded = false.obs;
  var isAreaLoading = false.obs;

  final universityModelLists = <UniversityModel>[];
  final collageList = <CollageModel>[];
  final departmentList = <DepartmentModel>[];
  final totalList = <TotalModel>[];
  final rateList = <TotalModel>[];
  final superlativeList = <TotalModel>[];
  final admissionList = <AdmissionModel>[];
  final universityAdmissionList = <UniversityAdmissionModel>[];
  final filterList = <UniversityAdmissionModel>[];

  final universityList = [];

  final areaList = <AreaModel>[];

  final durationList = [
    FilterModel(filterId: 1, filterName: 'Morning', dbId: 1),
    FilterModel(filterId: 2, filterName: 'Evening', dbId: 2),
  ];
  final universitySectorList = [
    FilterModel(filterId: 3, filterName: 'Governmental', dbId: 1),
    FilterModel(filterId: 4, filterName: 'Private', dbId: 2),
  ];
  final specialtyCategoryList = [
    FilterModel(filterId: 5, filterName: 'Bio', dbId: 1),
    FilterModel(filterId: 6, filterName: 'Applied Sciences', dbId: 2),
    FilterModel(filterId: 7, filterName: 'Literary', dbId: 3)
  ];
  final genderList = [
    FilterModel(filterId: 10, filterName: 'All', dbId: 1),
    FilterModel(filterId: 8, filterName: 'Male only', dbId: 3),
    FilterModel(filterId: 9, filterName: 'Female only', dbId: 2),
  ];
  final dateList = [
    FilterModel(filterId: 11, filterName: '2019'),
    FilterModel(filterId: 12, filterName: '2010')
  ];

  var priceSliderStart = 40.0;
  var priceSliderEnd = 60.0;

  late SfRangeValues sfRangeValues;

  AreaModel? dropdownValue;

  var searchBox = '';


  void goToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    // StorageService.to.isLoggedIn == true ? Get.off(() => const BottomBarNavigationView()) : Get.off(() => const OnBoarding());
  }

  void isItemSelected(int index, FilterModel filterModel) {
    switch (filterModel.filterId) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
      case 6:
      case 7:
        // Universty Category | Speacilty
        selectedSpecialtyCategoryItem = filterModel.dbId!;
        selectedSpecialtyCategoryIndex = index;
        update();
        filter();
        break;
      case 8:
      case 9:
      case 10:
        // Gender Selected
        selectedGenderItem = filterModel.dbId!;
        selectedGenderIndex = index;
        filter();
        break;
    }
  }

  @override
  void onInit() async {
    isUniversityLoaded(true);
    sfRangeValues = const SfRangeValues(40.0, 60.0);
    await getAreas();
    await getUniversities();
    await getCollages();
    await getDepartments();
    await getTotals();
    await getRates();
    await getSuperlative();
    await getAdmission();
    super.onInit();
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

    // print('admissionList=>${admissionModelListToJson(admissionList)}');
    // print('collageList=>${universitySectorList[0].filterName}');
    // for (var admissionModel in admissionList) {
    //   final sectorModel = universitySectorList
    //       .firstWhere((element) => element.dbId == admissionModel.sectorId);
    //   // final categoryModel = specialtyCategoryList.firstWhere((element) => element.dbId == admissionModel.categoryId);
    //   // final genderModel = genderList.firstWhere((element) => element.dbId == admissionModel.genderId);
    //   printInfo(info: 'collageNameEn=>${sectorModel?.filterName}');
    // }
    setUniversitiesAdmissionList();

    print(allData[0]);
  }

  Future getAreas() async {
    isAreaLoading(true);
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
    dropdownValue = areaList[0];
    isAreaLoading(false);
  }

  Future getUniversities() async {
    AreaModel? areaModel;

    universityModelLists.clear();
    QuerySnapshot querySnapshot = await UNIVERSITIES_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    final list = universities['universities'] as List<dynamic>;
    for (var element in list) {

      for (var areaElement in areaList) {
        if (element['area_id'] == areaElement.areaId) {
          areaModel = AreaModel(areaId: areaElement.areaId, areaName: areaElement.areaName);
        }
      }


      universityModelLists.add(UniversityModel(
          img: element['img'],
          universityId: element['university_Id'],
          genderId: element['gender_Id'],
          areaId: element['area_id'],
          areaModel: areaModel,
          universityNameEn: element['university_name_en'],
          universityNameAr: element['university_name_ar']));

      printInfo(info: 'areaModel>>${universityModelListToJson(universityModelLists!)}');
    }
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

  Future getTotals() async {
    totalList.clear();
    QuerySnapshot querySnapshot = await TOTAL_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['totals'] as List<dynamic>;
    for (var element in list) {
      totalList.add(
          TotalModel(totalId: element['total_Id'], total: element['total']));
    }
  }

  Future getRates() async {
    rateList.clear();
    QuerySnapshot querySnapshot = await RATE_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['rates'] as List<dynamic>;
    for (var element in list) {
      rateList
          .add(TotalModel(totalId: element['rate_Id'], total: element['rate']));
    }
    print(allData[0]);
  }

  Future getSuperlative() async {
    superlativeList.clear();
    QuerySnapshot querySnapshot = await SUPERLATIVE_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final collages = allData[0] as Map<String, dynamic>;
    final list = collages['superlativs'] as List<dynamic>;
    for (var element in list) {
      superlativeList.add(TotalModel(
          totalId: element['superlative_Id'], total: element['superlative']));
    }
    print(allData[0]);
  }

  void setUniversitiesAdmissionList() {
    DepartmentModel? departmentModel;

    // department_Id
    universityAdmissionList.clear();
    for (var admissionModel in admissionList) {
      final universityModel = universityModelLists.firstWhere((element) => element.universityId == admissionModel.universityId);
      final collageModel = collageList.firstWhereOrNull(
          (element) => element.collageId == admissionModel.collageId);
      if (departmentList.isNotEmpty) {
          departmentModel = departmentList.firstWhereOrNull((element) => element.departmentId == admissionModel.departmentId);
      }
      final totalModel = totalList.firstWhere((element) => element.totalId == admissionModel.totalId);
      final rateMode = rateList.firstWhere((element) => element.totalId == admissionModel.rateId);
      final superlative = superlativeList.firstWhere(
          (element) => element.totalId == admissionModel.superlativeId);
      final categoryModel = specialtyCategoryList
          .firstWhere((element) => element.dbId == admissionModel.categoryId);
      universityAdmissionList.add(UniversityAdmissionModel(
          universityModel: universityModel,
          categoryModel: categoryModel,
          collageModel: collageModel,
          departmentModel: departmentModel,
          isSaved: false,
          totalModel: totalModel,
          rateModel: rateMode,
          superlativeModel: superlative));

      filter();
      isUniversityLoaded(false);
    }
  }

  void updateRangeSlider(SfRangeValues newValues) {
    priceSliderStart = newValues.start;
    priceSliderEnd = newValues.end;

    filter();
  }

  void filter() {
    final List<UniversityAdmissionModel> tripList = [];
      if (searchBox.isNotEmpty) {
        for (var item in universityAdmissionList) {
          if (searchBox.toLowerCase().contains(item.universityModel!.universityNameEn!.toLowerCase()) || searchBox.toLowerCase().contains(item.collageModel!.collageNameEn!.toLowerCase()) &&
              item.rateModel!.total >= priceSliderStart &&
              item.rateModel!.total <= priceSliderEnd &&
              selectedGenderItem == item.universityModel!.genderId &&
              selectedSpecialtyCategoryItem == item.categoryModel!.dbId && dropdownValue!.areaId == item.universityModel!.areaId) {
            tripList.add(item);
          }
        }
      } else {
        for (var item in universityAdmissionList) {
          if (item.rateModel!.total >= priceSliderStart &&
                  item.rateModel!.total <= priceSliderEnd &&
                  selectedGenderItem == item.universityModel!.genderId &&
                  selectedSpecialtyCategoryItem == item.categoryModel!.dbId && dropdownValue!.areaId == item.universityModel!.areaId) {
            tripList.add(item);
          }
        }
      }

    filterList.clear();
    filterList.addAll(tripList);
    update();
  }

  void changeDropdownValue(AreaModel newValue) {
    dropdownValue = newValue;
    update();
  }

  void saveUniversityForm(int index, UniversityAdmissionModel universityModel) {
      savedUniversityIndex = index;
      universityModel.isSaved = true;
      printInfo(info: 'saveUniversityForm');
      formController.addTextFormField();
      formController.storeValue(formController.list.length - 1, '${universityModel.universityModel!.universityNameEn!}/${universityModel.collageModel!.collageNameEn}');
      update();
  }

  void removeUniversityForm(int index, UniversityAdmissionModel universityModel) {
      savedUniversityIndex = index;
      universityModel.isSaved = false;
      printInfo(info: 'saveUniversityForm');
      if (formController.list.isNotEmpty) {
        formController.removeTextFormField(formController.list.length - 1);
        savedUniversityIndex = -1;
      }
      update();
  }

  void updateRateController() {
    savedUniversityIndex = -1;
    update();
  }

}
