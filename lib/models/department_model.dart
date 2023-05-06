import 'dart:convert';

String departmentModelToJson(DepartmentModel data) => json.encode(data.toJson());

DepartmentModel departmentModelFromJson(String str) => DepartmentModel.fromJson(json.decode(str));

List<DepartmentModel>? departmentModelListFromJson(String str) =>
    List<DepartmentModel>.from(json.decode(str).map((x) => DepartmentModel.fromJson(x)));

String departmentModelListToJson(List<DepartmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentModel {
  String? _departmentNameAr;
  int? _departmentId;
  String? _departmentNameEn;

  DepartmentModel(
      {String? departmentNameAr, int? departmentId, String? departmentNameEn}) {
    if (departmentNameAr != null) {
      this._departmentNameAr = departmentNameAr;
    }
    if (departmentId != null) {
      this._departmentId = departmentId;
    }
    if (departmentNameEn != null) {
      this._departmentNameEn = departmentNameEn;
    }
  }

  String? get departmentNameAr => _departmentNameAr;
  set departmentNameAr(String? departmentNameAr) =>
      _departmentNameAr = departmentNameAr;
  int? get departmentId => _departmentId;
  set departmentId(int? departmentId) => _departmentId = departmentId;
  String? get departmentNameEn => _departmentNameEn;
  set departmentNameEn(String? departmentNameEn) =>
      _departmentNameEn = departmentNameEn;

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    _departmentNameAr = json['department_name_ar'];
    _departmentId = json['department_Id'];
    _departmentNameEn = json['department_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['department_name_ar'] = this._departmentNameAr;
    data['department_Id'] = this._departmentId;
    data['department_name_en'] = this._departmentNameEn;
    return data;
  }
}
