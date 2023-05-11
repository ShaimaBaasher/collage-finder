import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:io' as io;
import 'dart:ui' as ui;


import 'package:pdf/widgets.dart' as pw;

class FormTableController extends GetxController {
  List<Map<String, dynamic>> items = [];
  var imgPath = '';


  final pdf = pw.Document();

  @override
  void onInit() {
    super.onInit();
  }





}
