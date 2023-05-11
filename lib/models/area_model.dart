import 'dart:convert';

String areaModelToJson(AreaModel data) => json.encode(data.toJson());

AreaModel areaModelFromJson(String str) => AreaModel.fromJson(json.decode(str));

List<AreaModel>? areaModelListFromJson(String str) =>
    List<AreaModel>.from(json.decode(str).map((x) => AreaModel.fromJson(x)));

String areaModelListToJson(List<AreaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaList{
  List<AreaModel>? _list;

  AreaList({
    List<AreaModel>? list,
  }) {
    if (list != null) {
      _list = list;
    }
  }

  List<AreaModel>? get list => _list;

  set list(List<AreaModel>? list) => _list = list;

  AreaList.fromJson(Map<String, dynamic> json) {
    if (json['areas'] != null) {
      _list = <AreaModel>[];
      json['areas'].forEach((v) {
        _list!.add(AreaModel.fromJson(v));
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
