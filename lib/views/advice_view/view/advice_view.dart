import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/loading_widget.dart';
import '../controller/controller.dart';

class AdviceView extends StatelessWidget {
  const AdviceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    ));
  }
}
