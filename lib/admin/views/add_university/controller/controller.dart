import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/area_model.dart';
import '../../../../models/collage_model.dart';
import '../../../../models/filter_model.dart';
import '../../../../models/university_model.dart';
import '../../../../utils/constaints.dart';
import 'dart:io' as io;

import '../view/add_univresity_view.dart';

class AddUniversityController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  var isAreaLoading = false.obs;
  var isInsertingLoading = false.obs;

  var isImagePulledFromStorage = false;

  var isLoading = false.obs;

  var selectedChipItemIndex = 0;
  var isSwitched = false.obs;

  var imagePath = '';
  var imageUrl = '';

  String universityName = '';
  String aboutUniversity = '';

  late Gender? genderOption = Gender.male;
  Gender? genderRadioButton;

  AreaModel? dropdownValue;
  FilterModel genderValue =
      FilterModel(filterId: 10, filterName: 'All', dbId: 1);
  final areaList = <AreaModel>[];
  final universityModelLists = <UniversityModel>[];
  final addedUniversityModelLists = Map<String, dynamic>;
  final uploadedImagesLists = <Images>[];

  List<int> list = [];
  List<int> addedCollegelist = [];
  List<Map<String, dynamic>> items = [];
  var fieldCount = 0.obs;

  final genderList = [
    FilterModel(filterId: 10, filterName: 'All', dbId: 1),
    FilterModel(filterId: 8, filterName: 'Male only', dbId: 3),
    FilterModel(filterId: 9, filterName: 'Female only', dbId: 2),
  ];

  final collageList = <CollageModel>[];

  FilterModel? gender;

  @override
  void onInit() async {
    await getAreas();
    await getUniversities();
    await getCollages();
    super.onInit();
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    update();
  }

  Future uploadImage() async {
    if (imagePath.isNotEmpty) {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imagePath},
      );
      final fileName = await generateUuid();
      final storageRef = STORAGE_REF.child(fileName);
      await storageRef.putFile(io.File(imagePath), metadata);
      imageUrl = await storageRef.getDownloadURL();
    }
  }

  Future uploadImages(XFile img) async {
    if (img.path.isNotEmpty) {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': img.path},
      );
      final fileName = await generateUuid();
      final storageRef = STORAGE_REF.child(fileName);
      await storageRef.putFile(io.File(img.path), metadata);
      uploadedImagesLists
          .add(Images(imageUrl: await storageRef.getDownloadURL()));
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = io.File(image.path);
      imagePath = imageTemp.path;
      isImagePulledFromStorage = true;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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

  Future<String> generateUuid() async {
    return const Uuid().v4();
  }

  void changeDropdownValue(AreaModel newValue) {
    dropdownValue = newValue;
    update();
  }

  void setSelectedGender(Gender gender) {
    if (genderRadioButton == Gender.male) {
      this.gender = genderList[1];
    } else if (genderRadioButton == Gender.female) {
      this.gender = genderList[2];
    } else {
      this.gender = genderList[0];
    }
    update();
  }

  void uploadUniversity() async {
    isInsertingLoading(true);

    await getUniversities();
    // Images
    await uploadImage();
    if (imageFileList!.isNotEmpty) {
      for (var imageModel in imageFileList!) {
        await uploadImages(imageModel);
      }
    }

    universityModelLists.add(UniversityModel(
        universityId: universityModelLists.isNotEmpty
            ? universityModelLists[universityModelLists.length - 1].universityId! + 1 : 1,
        img: imageUrl,
        universityNameEn: universityName.trim(),
        about: aboutUniversity.trim(),
        images: uploadedImagesLists,
        areaId: dropdownValue?.areaId,
        collages: addedCollegelist));


    UNIVERSITIES_REF
        .doc('GAiapcDjqZzwXBQ24LYi')
        .set(UniversityList(universityModel: universityModelLists).toJson())
        .then((_) => EasyLoading.showSuccess('University Added Successfully'))
        .catchError(
            (error) => EasyLoading.showError('University Add failed $error'));

    clearFields();
    isInsertingLoading(false);
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

  Future getUniversities() async {
    AreaModel? areaModel;

    universityModelLists.clear();
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
          areaModel = AreaModel(
              areaId: areaElement.areaId, areaName: areaElement.areaName);
        }
      }

      universityModelLists.add(UniversityModel(
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

    printInfo(info: 'areaModel>>${universityModelListToJson(universityModelLists!)}');
  }

  void addTextFormField() {
    if (fieldCount.value <= 35) {
      fieldCount.value++;
      list.add(fieldCount.value);
    }
    update();
  }

  void storeValue(int i, CollageModel selection) {
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
    items.add({
      "field_id": i,
      "itinerary": selection.collageNameEn,
    });
    addedCollegelist.add(selection.collageId!);
    update();
  }

  void removeListData(int i) {
    if (addedCollegelist.isNotEmpty) {
      addedCollegelist.removeAt(i);
      update();
    }
  }

  void removeTextFormField(int i) {
    if (list.isNotEmpty) {
      fieldCount.value--;
      list.removeAt(i);
      removeListData(i);
    }
  }

  void clearFields() {
    fieldCount(0);
    addedCollegelist.clear();
    items.clear();
    list.clear();
    update();
  }
}
