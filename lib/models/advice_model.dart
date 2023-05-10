import 'dart:convert';


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
