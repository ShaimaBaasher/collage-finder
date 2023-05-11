import 'dart:convert';

String rateModelToJson(RateModel data) => json.encode(data.toJson());

RateModel rateModelFromJson(String str) => RateModel.fromJson(json.decode(str));

List<RateModel>? rateModelListFromJson(String str) =>
    List<RateModel>.from(json.decode(str).map((x) => RateModel.fromJson(x)));

String rateModelListToJson(List<RateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RateList{
  List<RateModel>? _rateModel;

  RateList({
    List<RateModel>? rateModel,
  }) {
    if (rateModel != null) {
      _rateModel = rateModel;
    }
  }

  List<RateModel>? get rateModel => _rateModel;

  set rateModel(List<RateModel>? rateModel) => _rateModel = rateModel;

  RateList.fromJson(Map<String, dynamic> json) {
    if (json['rates'] != null) {
      _rateModel = <RateModel>[];
      json['rates'].forEach((v) {
        _rateModel!.add(RateModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_rateModel != null) {
      data['rates'] = this._rateModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class RateModel {
  int? _rateId;
  dynamic _rate;

  RateModel({int? rateId, dynamic rate}) {
    if (rateId != null) {
      this._rateId = rateId;
    }
    if (rate != null) {
      this._rate = rate;
    }
  }

  int? get rateId => _rateId;
  set rateId(int? rateId) => _rateId = rateId;
  dynamic get rate => _rate;
  set rate(dynamic rate) => _rate = rate;

  RateModel.fromJson(Map<String, dynamic> json) {
    _rateId = json['rate_Id'];
    _rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate_Id'] = this._rateId;
    data['rate'] = this._rate;
    return data;
  }
}
