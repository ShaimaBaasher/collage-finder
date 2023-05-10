import 'package:collage_finder/views/advice_view/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdviceView extends StatelessWidget {
  AdviceView({Key? key}) : super(key: key);
  final controller = Get.find<AdviceController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            centerTitle: true,
            title: const Text("Advices"),
          ),
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.adviceList.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    ExpansionTile(
                      title: Text('${controller.adviceList[i].adviceTitle}'),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text('${controller.adviceList[i].adviceContent}'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
              // ListView.builder(itemBuilder: (ctx, i))
            ],
          ),
        ),
      ),
    ));
  }
}
