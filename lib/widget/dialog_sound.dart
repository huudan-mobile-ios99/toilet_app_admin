import 'package:flutter/material.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';

Widget myDialogDisplaySound({context, onPress}) {
  return Dialog(
    child: Container(
      width: MediaQuery.of(context).size.width / 2,
      // height: MediaQuery.of(context).size.height/2,
      padding: const EdgeInsets.all(PaddingDefault.padding16),
      decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: BorderRadius.circular(PaddingDefault.padding16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          text_custom(
              text: "Call Service Toilet From Customer",
              size: TextSizeDefault.text22,
              weight: FontWeight.bold,
              color: MyColor.yellow_accent),
          const SizedBox(
            height: PaddingDefault.pading08,
          ),
          Image.asset(
            "assets/notification_icon.png",
            width: 100.0,
          ),
          const SizedBox(
            height: PaddingDefault.pading08,
          ),
          text_custom(
              text:
                  "Please contact with cleanner and check toilet problems, thanks you",
              size: TextSizeDefault.text16),
          const SizedBox(
            height: PaddingDefault.pading08,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPress();
              },
              child: text_custom(
                  text: "CLOSE",
                  weight: FontWeight.bold,
                  size: TextSizeDefault.text22))
        ],
      ),
    ),
  );
}
