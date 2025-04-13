import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  /// **Text Styles**
  static const TextStyle appBarTitle = TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle hintTextStyle = TextStyle(
    color: Colors.grey,
  );

  static const TextStyle forgotPasswordText = TextStyle(
    color: Colors.black,
  );

  static const TextStyle buttonText = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
  static const TextStyle boldb15 = TextStyle(
    color: Colors.black,
     fontWeight: FontWeight.bold,
    fontSize: 15,
  );
 static const TextStyle font14b14 = TextStyle(
    fontSize: 14,
                                color: Colors.black54,
 

  );
  
      

  /// **Input Decoration (Common for TextFields)**
  static InputDecoration textFieldDecoration({
    required String hintText,
    required Icon prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintTextStyle,
      prefixIcon: prefixIcon,
      border: InputBorder.none,
      suffixIcon: suffixIcon,
    );
  }

  /// **Container Decoration (For TextFields)**
  static BoxDecoration textFieldContainer = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
  );

  /// **Login Button Decoration**
  static BoxDecoration loginButton = BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(20),
  );

  /// **Spacing**
  static SizedBox verticalSpace(double height) => SizedBox(height: height.h);
}
