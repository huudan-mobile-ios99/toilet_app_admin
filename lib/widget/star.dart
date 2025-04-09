import 'package:flutter/material.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/widget/button_custom.dart';

Widget starLineItem({int? index, bool? isActive = false, onPress}) {
  return customPressButton(
      padding: 64,
      onPress: () {
        // print('choose $index');
        onPress();
      },
      child: Icon(Icons.star,
          color: isActive == false ? MyColor.greyBG : MyColor.yellowBG,
          size: 72));
}


Widget starLineItemSmall({int? index, bool? isActive = false, onPress,size}) {
  return customPressButton(
      padding: size,
      onPress: () {
        // print('choose $index');
        onPress();
      },
      child: Icon(Icons.star,
          color: isActive == false ? MyColor.greyBG : MyColor.yellowBG,
          size: size));
}

