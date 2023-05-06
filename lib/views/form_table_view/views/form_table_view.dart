import 'package:collage_finder/views/form_table_view/widgets/row_table_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../contoller/controller.dart';

class FormTableView extends StatelessWidget {

  final controller = Get.find<FormTableController>();

  FormTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: controller.items.length,
              itemBuilder: (ctx, index) {
                return RowTableRow(index: index,);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
