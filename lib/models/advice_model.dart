import 'dart:convert';

String adviceModelToJson(AdviceModel data) => json.encode(data.toJson());

AdviceModel adviceModelFromJson(String str) => AdviceModel.fromJson(json.decode(str));

List<AdviceModel>? adviceModelListFromJson(String str) =>
    List<AdviceModel>.from(json.decode(str).map((x) => AdviceModel.fromJson(x)));

String adviceModelListToJson(List<AdviceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class AdviceList{
  List<AdviceModel>? _list;

  AdviceList({
    List<AdviceModel>? list,
  }) {
    if (list != null) {
      _list = list;
    }
  }

  List<AdviceModel>? get list => _list;

  set list(List<AdviceModel>? list) => _list = list;

  AdviceList.fromJson(Map<String, dynamic> json) {
    if (json['advices'] != null) {
      _list = <AdviceModel>[];
      json['advices'].forEach((v) {
        _list!.add(AdviceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (_list != null) {
      data['advices'] = _list!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class AdviceModel {
  String? _adviceContent;
  String? _adviceTitle;
  int? _id;

  AdviceModel({String? adviceContent, String? adviceTitle, int? id}) {
    if (adviceContent != null) {
      this._adviceContent = adviceContent;
    }
    if (adviceTitle != null) {
      this._adviceTitle = adviceTitle;
    }
    if (id != null) {
      this._id = id;
    }
  }

  String? get adviceContent => _adviceContent;
  set adviceContent(String? adviceContent) => _adviceContent = adviceContent;
  String? get adviceTitle => _adviceTitle;
  set adviceTitle(String? adviceTitle) => _adviceTitle = adviceTitle;
  int? get id => _id;
  set id(int? id) => _id = id;

  AdviceModel.fromJson(Map<String, dynamic> json) {
    _adviceContent = json['advice_content'];
    _adviceTitle = json['advice_title'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advice_content'] = this._adviceContent;
    data['advice_title'] = this._adviceTitle;
    data['id'] = this._id;
    return data;
  }
}
