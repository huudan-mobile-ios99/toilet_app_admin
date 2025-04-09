import 'package:flutter/material.dart';

import '../utils/mycolors.dart';

Widget customPressButton({double? padding,onPress,double? width,child}){
  return ClipRRect(
    borderRadius: BorderRadius.circular(padding!),
    child:  Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: MyColor.yellow_bg,
          onTap: ()=>onPress(),
          child: child
        ),
      ),
  );
}