import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../widgets/pdfexport.dart';
import '../contoller/controller.dart';

class FormTableView extends StatelessWidget {
  final controller = Get.find<FormTableController>();

  FormTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: PdfPreview(
                  build: (context) => makePdf(controller.items),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
