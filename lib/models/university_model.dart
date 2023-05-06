import 'dart:convert';

import 'package:collage_finder/models/filter_model.dart';

String universityModelToJson(UniversityModel data) => json.encode(data.toJson());

UniversityModel universityModelFromJson(String str) => UniversityModel.fromJson(json.decode(str));

List<UniversityModel>? universityModelListFromJson(String str) =>
    List<UniversityModel>.from(json.decode(str).map((x) => UniversityModel.fromJson(x)));

String universityModelListToJson(List<UniversityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class UniversityModel {
  String? _img;
  String? _universityNameAr;
  int? _universityId;
  String? _universityNameEn;
  int? _areaId;

  UniversityModel(
      {String? img, String? universityNameAr, int? universityId, String? universityNameEn, int? areaId}) {
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

  String? get img => _img;
  set img(String? img) =>
      _img = img;
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

  UniversityModel.fromJson(Map<String, dynamic> json) {
    _img = json['img'];
    _universityNameAr = json['university_name_ar'];
    _universityId = json['university_Id'];
    _universityNameEn = json['university_name_en'];
    _areaId = json['area_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this._img;
    data['university_name_ar'] = this._universityNameAr;
    data['university_Id'] = this._universityId;
    data['university_name_en'] = this._universityNameEn;
    data['area_id'] = this._areaId;
    return data;
  }
}
