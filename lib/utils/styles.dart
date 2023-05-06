import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:math';

final themeData = ThemeData(
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xFF1E88E5),
  ),
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.blue,
  fontFamily: 'tajawal',
  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
);

inputDecoration(
  String? hint,
) {
  return InputDecoration(
    filled: true,
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
    fillColor: Colors.black12.withOpacity(0.06),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black12),
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
  );
}

inputPinDecoration(
  String? hint,
) {
  return InputDecoration(
    filled: true,
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 15, color: Colors.red),
    fillColor: Colors.black12.withOpacity(0.06),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black12),
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
  );
}

inputDecorationSuffix(String? hint) {
  return InputDecoration(
    suffix: Text('SDG'.tr),
    filled: true,
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 15),
    fillColor: Colors.black12.withOpacity(0.06),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black12),
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
  );
}

// #f44a4a Purple 300
// const kPrimaryColor = Color(0xFF9293FF);
const kPrimaryColor = Colors.blue;
const kPinkColor = Color(0xFFFF626A);
var kPinkLightColor = const Color(0xFFFF626A).withOpacity(0.1);
const kPurpleColor = Color(0xFF512DA8);
const kHeadingTextColor = Color(0xFF707070);
const kTextFieldColor = Color(0xFFf5f6f6);
const indicatorColor = Color(0xFFc3c5c8);
const borderColor = Color(0xFFe0e1e2);
const buttonColor = Color(0xFF979797);
var kPurpleLightColor = const Color(0xFF512DA8).withOpacity(0.1);
var kPurpleLight6Color = const Color(0xFF512DA8).withOpacity(0.6);
var kWhiteTransColor = const Color(0xFFFFFFFF).withOpacity(0.6);

final kPinkDefaultTextStyle = TextStyle(
  color: kPinkColor,
  fontSize: 16.0,
  fontFamily: 'tajawal',
);

final kTextFieldTextStyle = TextStyle(
  color:  Colors.grey[400],
  fontSize: 14.0,
  fontFamily: 'tajawal',
);

final kLabelPrimaryTextStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
  fontFamily: 'tajawal',
);

final kLabelPrimaryNormalTextStyle = TextStyle(
  color: Colors.black87,
  fontSize: 17.0.sp,
  fontFamily: 'tajawal',
);

final kLabelSecondryTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 16.0,
  fontFamily: 'tajawal',
);

final kLabelWhiteTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontFamily: 'tajawal',
);

final kPrivacyTextStyle = TextStyle(
  height: 1.2,
  color: Colors.black87,
  fontSize: 15.0,
  fontFamily: 'tajawal',
);

final kPrivacyBlueTextStyle = TextStyle(
  height: 1.2,
  color: Colors.blue,
  fontSize: 15.0,
  fontFamily: 'tajawal',
);

final kRadioLabelTextStyle = TextStyle(
  color: Colors.black87,
  fontSize: 17.0,
  fontFamily: 'tajawal',
);

final kSecondaryTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 14.0,
  fontFamily: 'tajawal',
);

final kDefaultTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontFamily: 'tajawal',
);

final kPurpleTextStyle = TextStyle(
  color: kPurpleColor,
  fontSize: 16.0,
  fontFamily: 'tajawal',
);

final kHeadingTextStyle = TextStyle(
  color: kHeadingTextColor,
  fontSize: 22.0,
);
