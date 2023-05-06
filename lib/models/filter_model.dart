import 'dart:convert';


class FilterModel {
  int? filterId;
  String? filterName;
  int? dbId;

  FilterModel({required this.filterId, required this.filterName, this.dbId});

}