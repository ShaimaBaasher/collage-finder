import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_finder/models/area_model.dart';
import 'package:collage_finder/models/collage_model.dart';
import 'package:get/get.dart';

import '../../../models/university_model.dart';
import '../../../utils/constaints.dart';
import '../../../utils/routes/app_pages.dart';

class CollageController extends GetxController {
  final universityList = <UniversityModel>[];
  final filterList = <UniversityModel>[];
  final collageList = <CollageModel>[];
  final areaList = <AreaModel>[];

  var searchBox = '';

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
          areaModel = AreaModel(areaId: areaElement.areaId, areaName: areaElement.areaName);
        }
      }

      universityList.add(UniversityModel(
          img: element['img'],
          images: imgList,
          collages: cList,
          about: element['about'],
          areaModel:  areaModel,
          universityId: element['university_Id'],
          areaId: element['area_id'],
          universityNameEn: element['university_name_en'],
          universityNameAr: element['university_name_ar']));
    }
    isUniversityLoading(false);
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
    for (var i = 0; i < universityModel!.collages!.length; i++) {
      if (innerCollageList[i].collageId == universityModel!.collages![i]) {
        collageList.add(CollageModel(
            collageId: innerCollageList[i].collageId,
            collageNameEn: innerCollageList[i].collageNameEn));
      }
    }
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
      areaList.add(AreaModel(
        areaId: element['area_Id'],
        areaName: element['area_name'],
      ));
    }
    printInfo(info: 'areas>>${areaModelListToJson(areaList!)}');
  }

  void filter() {}

  void openUniversityDetails(UniversityModel universityModel) async {
    isCollagesLoading(true);
    this.universityModel = universityModel;
    Get.toNamed(Routes.universityDetailsView,);
    await getCollages();
    isCollagesLoading(false);
  }

}
