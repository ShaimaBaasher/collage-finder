import 'dart:convert';

String admissionModelToJson(AdmissionModel data) => json.encode(data.toJson());

AdmissionModel admissionModelFromJson(String str) => AdmissionModel.fromJson(json.decode(str));

List<AdmissionModel>? admissionModelListFromJson(String str) =>
    List<AdmissionModel>.from(json.decode(str).map((x) => AdmissionModel.fromJson(x)));

String admissionModelListToJson(List<AdmissionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdmissionList {
  List<AdmissionModel>? _list;

  AdmissionList({List<AdmissionModel>? list,}) {
    if (list != null) {
      _list = list;
    }
  }

  List<AdmissionModel>? get list => _list;

  set list(List<AdmissionModel>? list) => _list = list;

  AdmissionList.fromJson(Map<String, dynamic> json) {
    if (json['admission-rate'] != null) {
      _list = <AdmissionModel>[];
      json['admission-rate'].forEach((v) {
        _list!.add(AdmissionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_list != null) {
      data['areas'] = _list!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class AdmissionModel {
  int? _totalId;
  int? _universityId;
  int? _categoryId;
  int? _collageId;
  int? _rateId;
  int? _departmentId;
  int? _sectorId;
  int? _superlativeId;

  AdmissionModel(
      {int? totalId,
        int? universityId,
        int? categoryId,
        int? collageId,
        int? rateId,
        int? departmentId,
        int? sectorId,
        int? superlativeId}) {
    if (totalId != null) {
      this._totalId = totalId;
    }
    if (universityId != null) {
      this._universityId = universityId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (collageId != null) {
      this._collageId = collageId;
    }
    if (rateId != null) {
      this._rateId = rateId;
    }
    if (departmentId != null) {
      this._departmentId = departmentId;
    }
    if (sectorId != null) {
      this._sectorId = sectorId;
    }
    if (superlativeId != null) {
      this._superlativeId = superlativeId;
    }
  }

  int? get totalId => _totalId;
  set totalId(int? totalId) => _totalId = totalId;
  int? get universityId => _universityId;
  set universityId(int? universityId) => _universityId = universityId;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  int? get collageId => _collageId;
  set collageId(int? collageId) => _collageId = collageId;
  int? get rateId => _rateId;
  set rateId(int? rateId) => _rateId = rateId;
  int? get departmentId => _departmentId;
  set departmentId(int? departmentId) => _departmentId = departmentId;
  int? get sectorId => _sectorId;
  set sectorId(int? sectorId) => _sectorId = sectorId;
  int? get superlativeId => _superlativeId;
  set superlativeId(int? superlativeId) => _superlativeId = superlativeId;

  AdmissionModel.fromJson(Map<String, dynamic> json) {
    _totalId = json['total_Id'];
    _universityId = json['university_Id'];
    _categoryId = json['category_Id'];
    _collageId = json['collage_Id'];
    _rateId = json['rate_Id'];
    _departmentId = json['department_Id'];
    _sectorId = json['sector_Id'];
    _superlativeId = json['superlative_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_Id'] = this._totalId;
    data['university_Id'] = this._universityId;
    data['category_Id'] = this._categoryId;
    data['collage_Id'] = this._collageId;
    data['rate_Id'] = this._rateId;
    data['department_Id'] = this._departmentId;
    data['sector_Id'] = this._sectorId;
    data['superlative_Id'] = this._superlativeId;
    return data;
  }
}
