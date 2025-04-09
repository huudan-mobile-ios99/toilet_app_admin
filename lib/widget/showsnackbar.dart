import 'package:flutter/material.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/text.dart';

void showSnackBar({String? message, BuildContext? context,int? duncration_second ,onPressed}) {
  final snackBar = SnackBar(
    duration:  Duration(seconds: duncration_second!),
    backgroundColor: MyColor.black_text,
    content:
    text_custom(text:message,color:MyColor.white,size: 16),
    action: SnackBarAction(label: ">", onPressed: onPressed),
     
  );
  ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}