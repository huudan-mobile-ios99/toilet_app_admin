import 'package:flutter/material.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';

Widget confirmed_mark(value) {
  return value == true
      ? Positioned(
          right: PaddingDefault.padding00,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingDefault.padding16,
                vertical: PaddingDefault.padding04),
            decoration: BoxDecoration(
                color: MyColor.green,
                borderRadius: BorderRadius.circular(PaddingDefault.padding24)),
            child: text_custom(
                text: "CONFIRMED ✅",
                weight: FontWeight.bold,
                size: TextSizeDefault.text14,
                color: MyColor.white),
          ))
      : Container();
}
