import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/models/area_model.dart';
import 'package:collage_finder/models/department_model.dart';
import 'package:get/get.dart';

import '../../../models/university_model.dart';
import '../../../utils/constaints.dart';
import '../../../utils/routes/app_pages.dart';

class CollageController extends GetxController {
  final universityList = <UniversityModel>[];
  final filterList = <UniversityModel>[];
  final departmentList = <DepartmentModel>[];
  final areaList = <AreaModel>[];

  var searchBox = '';

  var isUniversityLoading = false.obs;

  UniversityModel? universityModel;

  @override
  void onInit() {
    getAreas();
    getDepartments();
    getUniversities();
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
      final list = element['images'] as List<dynamic>;
      for (var imgElement in list) {
        imgList.add(Images(imageUrl: imgElement["imageUrl"]));
      }
      universityList.add(UniversityModel(
          img: element['img'],
          images: imgList,
          about: element['about'],
          universityId: element['university_Id'],
          areaId: element['area_id'],
          universityNameEn: element['university_name_en'],
          universityNameAr: element['university_name_ar']));
    }
    isUniversityLoading(false);
  }

  Future getDepartments() async {
    // isUniversityLoading(true);
    departmentList.clear();
    QuerySnapshot querySnapshot = await DEPARTMENT_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    final list = universities['departments'] as List<dynamic>;
    printInfo(info: 'departments>>${universities['departments']}');
    for (var element in list) {
      departmentList.add(DepartmentModel(
        departmentId: element['department_Id'],
        departmentNameEn: element['department_name_en'],
      ));
    }
  }

  Future getAreas() async {
    // isUniversityLoading(true);
    areaList.clear();
    QuerySnapshot querySnapshot = await DEPARTMENT_REF.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final universities = allData[0] as Map<String, dynamic>;
    final list = universities['areas'] as List<dynamic>;
    printInfo(info: 'departments>>${universities['areas']}');
    for (var element in list) {
      areaList.add(AreaModel(
        areaId: element['area_Id'],
        areaName: element['area_name'],
      ));
    }
  }

  void filter() {}

  void openUniversityDetails(UniversityModel universityModel) {
    this.universityModel = universityModel;
    Get.toNamed(Routes.universityDetailsView,);
  }
}
