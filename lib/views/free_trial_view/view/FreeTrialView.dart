import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/styles.dart';

class FreeTrailView extends StatelessWidget {
  const FreeTrailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
          ),
      body: Center(child: Text('Sorry App Free Trial Ended', style: kLabelPrimaryTextStyle.copyWith(fontSize: 19.sp),),),
    ));
  }
}
