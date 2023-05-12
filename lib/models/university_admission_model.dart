import 'dart:convert';

import 'package:collage_finder/models/collage_model.dart';
import 'package:collage_finder/models/department_model.dart';
import 'package:collage_finder/models/total_model.dart';

import 'filter_model.dart';
import 'university_model.dart';

// String universityAdmissionModelListToJson(List<UniversityAdmissionModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniversityAdmissionModel {
  UniversityModel? _universityModel;
  FilterModel? _areaModel;
  FilterModel? _sectorModel;
  FilterModel? _categoryModel;
  FilterModel? _genderModel;
  CollageModel? _collageModel;
  DepartmentModel? _departmentModel;
  TotalModel? _totalModel;
  TotalModel? _rateModel;
  TotalModel? _superlativeModel;
  bool? _isSaved;

  UniversityAdmissionModel(
      {UniversityModel? universityModel, FilterModel? areaModel, FilterModel? sectorModel, FilterModel? categoryModel,
        FilterModel? genderModel, CollageModel? collageModel, DepartmentModel? departmentModel, TotalModel? totalModel,
      TotalModel? rateModel, TotalModel? superlativeModel, bool? isSaved}) {
    if (isSaved != null) {
      this._isSaved = isSaved;
    }
    if (universityModel != null) {
      this._universityModel = universityModel;
    }
    if (areaModel != null) {
      this._areaModel = areaModel;
    }
    if (sectorModel != null) {
      this._sectorModel = sectorModel;
    }
    if (categoryModel != null) {
      this._categoryModel = categoryModel;
    }
    if (genderModel != null) {
      this._genderModel = genderModel;
    }
    if (collageModel != null) {
      this._collageModel = collageModel;
    }
    if (departmentModel != null) {
      this._departmentModel = departmentModel;
    }
    if (totalModel != null) {
      this._totalModel = totalModel;
    }
    if (rateModel != null) {
      this._rateModel = rateModel;
    }
    if (superlativeModel != null) {
      this._superlativeModel = superlativeModel;
    }
  }

  bool? get isSaved => _isSaved;

  set isSaved(bool? isSaved) =>
      _isSaved = isSaved;

  UniversityModel? get universityModel => _universityModel;

  set universityModel(UniversityModel? universityModel) =>
      _universityModel = universityModel;

  FilterModel? get sectorModel => _sectorModel;

  set sectorModel(FilterModel? universityId) => _sectorModel = sectorModel;

  FilterModel? get areaModel => _areaModel;

  set areaModel(FilterModel? areaModel) => _areaModel = areaModel;

  FilterModel? get categoryModel => _categoryModel;

  set categoryModel(FilterModel? categoryModel) =>
      _categoryModel = categoryModel;

  FilterModel? get genderModel => _genderModel;

  set genderModel(FilterModel? genderModel) =>
      _genderModel = genderModel;

  CollageModel? get collageModel => _collageModel;

  set collageModel(CollageModel? collageModel) =>
      _collageModel = collageModel;

  DepartmentModel? get departmentModel => _departmentModel;

  set departmentModel(DepartmentModel? departmentModel) =>
      _departmentModel = departmentModel;

  TotalModel? get totalModel => _totalModel;

  set totalModel(TotalModel? departmentModel) =>
      _totalModel = totalModel;

  TotalModel? get rateModel => _rateModel;

  set rateModel(TotalModel? rateModel) =>
      _rateModel = rateModel;

  TotalModel? get superlativeModel => _superlativeModel;

  set superlativeModel(TotalModel? superlativeModel) =>
      _superlativeModel = superlativeModel;

}
