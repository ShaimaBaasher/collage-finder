import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 1.h,
        ),
        Divider(),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  }
}
