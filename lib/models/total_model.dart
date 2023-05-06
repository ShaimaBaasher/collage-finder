import 'dart:convert';

String totalModelToJson(TotalModel data) => json.encode(data.toJson());

TotalModel totalModelFromJson(String str) => TotalModel.fromJson(json.decode(str));

List<TotalModel>? totalModelListFromJson(String str) =>
    List<TotalModel>.from(json.decode(str).map((x) => TotalModel.fromJson(x)));

String totalModelListToJson(List<TotalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalModel {
  int? _totalId;
  dynamic _total;

  TotalModel({int? totalId, dynamic? total}) {
    if (totalId != null) {
      this._totalId = totalId;
    }
    if (total != null) {
      this._total = total;
    }
  }

  int? get totalId => _totalId;
  set totalId(int? totalId) => _totalId = totalId;
  dynamic? get total => _total;
  set total(dynamic? total) => _total = total;

  TotalModel.fromJson(Map<String, dynamic> json) {
    _totalId = json['total_Id'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_Id'] = this._totalId;
    data['total'] = this._total;
    return data;
  }
}
