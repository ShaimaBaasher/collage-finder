import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' as io;
import 'dart:ui' as ui;

import 'package:share_plus/share_plus.dart';

class FormTableController extends GetxController {

  List<Map<String, dynamic>> items = [];
  var imgPath = '';

@override
  void onInit() {
    super.onInit();
  }

  Future<String?> takeScreenshot(GlobalKey<State<StatefulWidget>> globalKey) async {

    try {
      if (await Permission.storage.request().isRestricted) {
        await [Permission.storage,].request();
      }

      final status = await Permission.storage.status;

      if(status.isGranted) {
        RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage();
        ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
        var pngBytes = byteData?.buffer.asUint8List();
        var bs64 = base64Encode(pngBytes!);
        print(pngBytes);
        final savedPath = await savePng(pngBytes);
        print(bs64);
        update();
        // setState(() {});
        return savedPath;
      } else {
        EasyLoading.showInfo('receipt_saved_successfully'.tr);
      }

    } catch (e) {
      print(e);
    }
  }

  Future<String> savePng(Uint8List capturedImage) async {
    final tempDir = await syspaths.getTemporaryDirectory();
    String tempPath = tempDir.path;
    final fileName = "yallabook_receipt_${DateTime.now().millisecondsSinceEpoch}";
    String imgFilePath = '$tempPath/$fileName.png';
    io.File imgFile = io.File(imgFilePath);
    await imgFile.writeAsBytes(capturedImage);
    final result = await ImageGallerySaver.saveFile(imgFilePath);
    imgPath = imgFilePath;
    return imgFilePath;
  }

  Future shareReceipt(GlobalKey<State<StatefulWidget>> globalKey) async {

    final imgFilePath = await takeScreenshot(globalKey);
    if(imgFilePath != null) {
      Share.shareFiles(
        [imgFilePath],
        text: 'collage_finder',
      );
    }
  }

}
