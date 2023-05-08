import 'dart:convert';

import 'package:collage_finder/models/area_model.dart';
import 'package:collage_finder/models/department_model.dart';
import 'package:collage_finder/models/filter_model.dart';

String universityModelToJson(UniversityModel data) =>
    json.encode(data.toJson());

UniversityModel universityModelFromJson(String str) =>
    UniversityModel.fromJson(json.decode(str));

List<UniversityModel>? universityModelListFromJson(String str) =>
    List<UniversityModel>.from(
        json.decode(str).map((x) => UniversityModel.fromJson(x)));

String universityModelListToJson(List<UniversityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniversityModel {
  String? _img;
  int? _universityId;
  String? _universityNameAr;
  String? _universityNameEn;
  String? _about;
  int? _areaId;
  int? _genderId;
  AreaModel? _areaModel;
  List<int>? _collages;
  List<Images>? _images;

  UniversityModel({
    String? img,
    String? universityNameAr,
    int? universityId,
    List<int>? collages,
    int? genderId,
    String? universityNameEn,
    String? about,
    AreaModel? areaModel,
    int? areaId,
    List<Images>? images,
  }) {
    if (areaModel != null) {
      this._areaModel = areaModel;
    }
    if (genderId != null) {
      this._genderId = genderId;
    }
    if (about != null) {
      this._about = about;
    }
    if (collages != null) {
      this._collages = collages;
    }
    if (images != null) {
      this._images = images;
    }
    if (img != null) {
      this._img = img;
    }
    if (universityNameAr != null) {
      this._universityNameAr = universityNameAr;
    }
    if (universityId != null) {
      this._universityId = universityId;
    }
    if (universityNameEn != null) {
      this._universityNameEn = universityNameEn;
    }
    if (areaId != null) {
      this._areaId = areaId;
    }
  }

  List<int>? get collages => _collages;

  set collages(List<int>? collages) => _collages = collages;

  List<Images>? get images => _images;

  set images(List<Images>? images) => _images = images;

  AreaModel? get areaModel => _areaModel;

  set areaModel(AreaModel? areaModel) => _areaModel = areaModel;

  String? get img => _img;

  set img(String? img) => _img = img;

  String? get about => _about;

  set about(String? about) => _about = about;

  String? get universityNameAr => _universityNameAr;

  set universityNameAr(String? universityNameAr) =>
      _universityNameAr = universityNameAr;

  int? get universityId => _universityId;

  set universityId(int? universityId) => _universityId = universityId;

  int? get areaId => _areaId;

  set areaId(int? areaId) => _areaId = areaId;

  String? get universityNameEn => _universityNameEn;

  set universityNameEn(String? universityNameEn) =>
      _universityNameEn = universityNameEn;

  int? get genderId => _genderId;
  set genderId(int? genderId) => _genderId = genderId;

  UniversityModel.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      _images = <Images>[];
      json['images'].forEach((v) {
        _images!.add(new Images.fromJson(v));
      });
    }
    _genderId = json['gender_Id'];
    _collages = json['collages'].cast<int>();
    _img = json['img'];
    _about = json['about'];
    _universityNameAr = json['university_name_ar'];
    _universityId = json['university_Id'];
    _universityNameEn = json['university_name_en'];
    _areaId = json['area_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._images != null) {
      data['images'] = this._images!.map((v) => v.toJson()).toList();
    }
    data['gender_Id'] = this._genderId;
    data['collages'] = this._collages;
    data['img'] = this._img;
    data['about'] = this._about;
    data['university_name_ar'] = this._universityNameAr;
    data['university_Id'] = this._universityId;
    data['university_name_en'] = this._universityNameEn;
    data['area_id'] = this._areaId;
    return data;
  }
}

class Images {
  String? _imageUrl;

  Images({String? imageUrl}) {
    if (imageUrl != null) {
      this._imageUrl = imageUrl;
    }
  }

  String? get imageUrl => _imageUrl;

  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;

  Images.fromJson(Map<String, dynamic> json) {
    _imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this._imageUrl;
    return data;
  }
}
