import 'dart:convert';

String areaModelToJson(AreaModel data) => json.encode(data.toJson());

AreaModel areaModelFromJson(String str) => AreaModel.fromJson(json.decode(str));

List<AreaModel>? areaModelListFromJson(String str) =>
    List<AreaModel>.from(json.decode(str).map((x) => AreaModel.fromJson(x)));

String areaModelListToJson(List<AreaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaModel {
  int? _areaId;
  String? _areaName;

  AreaModel({int? areaId, String? areaName}) {
    if (areaId != null) {
      this._areaId = areaId;
    }
    if (areaName != null) {
      this._areaName = areaName;
    }
  }

  int? get areaId => _areaId;
  set areaId(int? areaId) => _areaId = areaId;
  String? get areaName => _areaName;
  set areaName(String? areaName) => _areaName = areaName;

  AreaModel.fromJson(Map<String, dynamic> json) {
    _areaId = json['area_Id'];
    _areaName = json['area_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_Id'] = this._areaId;
    data['area_name'] = this._areaName;
    return data;
  }
}
