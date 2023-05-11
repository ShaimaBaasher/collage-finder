import 'dart:convert';

String collagesModelToJson(CollageModel data) => json.encode(data.toJson());

CollageModel collagesModelFromJson(String str) => CollageModel.fromJson(json.decode(str));

List<CollageModel>? collagesModelListFromJson(String str) =>
    List<CollageModel>.from(json.decode(str).map((x) => CollageModel.fromJson(x)));

String collagesModelListToJson(List<CollageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollageModel {
  String? _collageNameEn;
  int? _collageId;
  String? _collageNameAr;
  bool? _isSaved;
  dynamic _rate;

  CollageModel({String? collageNameEn, int? collageId, bool? isSaved, String? collageNameAr, dynamic rate}) {
    if (rate != null) {
      this._rate = rate;
    }
    if (isSaved != null) {
      this._isSaved = isSaved;
    }
    if (collageNameEn != null) {
      this._collageNameEn = collageNameEn;
    }
    if (collageId != null) {
      this._collageId = collageId;
    }
    if (collageNameAr != null) {
      this._collageNameAr = collageNameAr;
    }
  }

  dynamic get rate => _rate;
  set rate(dynamic rate) => _rate = rate;

  bool? get isSaved => _isSaved;
  set isSaved(bool? isSaved) => _isSaved = isSaved;

  String? get collageNameEn => _collageNameEn;
  set collageNameEn(String? collageNameEn) => _collageNameEn = collageNameEn;
  int? get collageId => _collageId;
  set collageId(int? collageId) => _collageId = collageId;
  String? get collageNameAr => _collageNameAr;
  set collageNameAr(String? collageNameAr) => _collageNameAr = collageNameAr;

  CollageModel.fromJson(Map<String, dynamic> json) {
    _collageNameEn = json['collage_name_en'];
    _collageId = json['collage_Id'];
    _collageNameAr = json['collage_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collage_name_en'] = this._collageNameEn;
    data['collage_Id'] = this._collageId;
    data['collage_name_ar'] = this._collageNameAr;
    return data;
  }
}
