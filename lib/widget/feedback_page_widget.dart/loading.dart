
import 'package:flutter/material.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';
Widget loading_line() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      text_custom(
          text: 'LOADING ', color: MyColor.white, size: TextSizeDefault.text18),
      const CircularProgressIndicator(
        color: Colors.white,
      ),
    ],
  );
}
