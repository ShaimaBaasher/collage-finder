import 'dart:convert';


List<SavedUniModel>? savedUniModelListFromJson(String str) =>
    List<SavedUniModel>.from(
        json.decode(str).map((x) => SavedUniModel.fromJson(x)));

class SavedUniModel {
  String? uniCollageName;
  int? un_Id;
  int? cat_Id;

  SavedUniModel({required this.uniCollageName, required this.un_Id, required this.cat_Id,});

  SavedUniModel.fromJson(Map<String, dynamic> json) {
    uniCollageName = json['uniCollageName'];
    un_Id = json['un_Id'];
    cat_Id = json['cat_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniCollageName'] = this.uniCollageName;
    data['un_Id'] = this.un_Id;
    data['cat_Id'] = this.cat_Id;
    return data;
  }
}