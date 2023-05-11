import 'dart:convert';

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

List<CategoryModel>? categoryModelListFromJson(String str) =>
    List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelListToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryList{
  List<CategoryModel>? _list;

  CategoryList({
    List<CategoryModel>? list,
  }) {
    if (list != null) {
      _list = list;
    }
  }

  List<CategoryModel>? get list => _list;

  set list(List<CategoryModel>? list) => _list = list;

  CategoryList.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      _list = <CategoryModel>[];
      json['categories'].forEach((v) {
        _list!.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_list != null) {
      data['categories'] = this._list!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class CategoryModel {
  int? _categoryId;
  String? _categoryNameEn;

  CategoryModel({int? categoryId, String? categoryNameEn}) {
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (categoryNameEn != null) {
      this._categoryNameEn = categoryNameEn;
    }
  }

  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  String? get categoryNameEn => _categoryNameEn;
  set categoryNameEn(String? categoryNameEn) =>
      _categoryNameEn = categoryNameEn;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    _categoryId = json['category_Id'];
    _categoryNameEn = json['category_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_Id'] = this._categoryId;
    data['category_name_en'] = this._categoryNameEn;
    return data;
  }
}
