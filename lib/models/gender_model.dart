import 'dart:convert';

String genderModelToJson(GenderModel data) => json.encode(data.toJson());

GenderModel genderModelFromJson(String str) => GenderModel.fromJson(json.decode(str));

List<GenderModel>? genderModelListFromJson(String str) =>
    List<GenderModel>.from(json.decode(str).map((x) => GenderModel.fromJson(x)));

String genderModelListToJson(List<GenderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GenderModel {
  String? _genderNameEn;
  int? _genderId;
  String? _genderNameAr;

  GenderModel({String? genderNameEn, int? genderId, String? genderNameAr}) {
    if (genderNameEn != null) {
      this._genderNameEn = genderNameEn;
    }
    if (genderId != null) {
      this._genderId = genderId;
    }
    if (genderNameAr != null) {
      this._genderNameAr = genderNameAr;
    }
  }

  String? get genderNameEn => _genderNameEn;
  set genderNameEn(String? genderNameEn) => _genderNameEn = genderNameEn;
  int? get genderId => _genderId;
  set genderId(int? genderId) => _genderId = genderId;
  String? get genderNameAr => _genderNameAr;
  set genderNameAr(String? genderNameAr) => _genderNameAr = genderNameAr;

  GenderModel.fromJson(Map<String, dynamic> json) {
    _genderNameEn = json['gender_name_en'];
    _genderId = json['gender_Id'];
    _genderNameAr = json['gender_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender_name_en'] = this._genderNameEn;
    data['gender_Id'] = this._genderId;
    data['gender_name_ar'] = this._genderNameAr;
    return data;
  }
}
