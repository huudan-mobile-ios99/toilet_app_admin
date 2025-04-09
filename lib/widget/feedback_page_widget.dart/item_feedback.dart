import 'package:flutter/material.dart';
import 'package:toilet_admin/model/feedback_model_w_status.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';
import 'package:toilet_admin/widget/feedback_page_widget.dart/confirm_mark.dart';
import 'package:toilet_admin/widget/item_star.dart';
import 'package:toilet_admin/widget/item_toilet.dart';

Widget item_feedback({width,height,index,format_datetime,FeedbackModelWStatus? model}) {
  return Stack(
    children: [
      Container(
          decoration: BoxDecoration(
              color: MyColor.white,
              borderRadius: BorderRadius.circular(PaddingDefault.padding24)),
          margin: const EdgeInsets.only(bottom: PaddingDefault.pading12),
          padding: const EdgeInsets.all(PaddingDefault.pading08),
          child: Row(
            children: [
              SizedBox(
                  width: width * .065,
                  child: text_custom(
                      text: '#${index + 1}', size: TextSizeDefault.text32)),
              Container(
                  alignment: Alignment.centerLeft,
                  width: width * .7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      model!.data[index].experience.isNotEmpty
                          ? rowToiletDisplay(
                              input: model.data[index].experience)
                          : text_custom(
                              text: 'NO FEEDBACK',
                              weight: FontWeight.w600,
                              size: 16),
                      rowStarDisplay(
                          size: PaddingDefault.padding24,
                          input: model.data[index].star ?? 0),
                    ],
                  )),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text_custom(
                      text: "Created Datetime",
                      weight: FontWeight.bold,
                      size: 14,
                      color: MyColor.grey),
                  text_custom(
                      size: TextSizeDefault.text16,
                      text: format_datetime.formatDateTimeWithSplash(model.data[index].createdAt)),
                  model.data[index].isprocess == true
                      ? text_custom(
                          text: "Confirmed Datetime",
                          weight: FontWeight.bold,
                          size: 14,
                          color: MyColor.grey)
                      : Container(),
                  model.data[index].isprocess == true
                      ? text_custom(
                          size: TextSizeDefault.text16,
                          text: format_datetime.formatDateTimeWithSplash(
                              model.data[index].processCreatedAt))
                      : Container(),
                ],
              )),
            ],
          )),
      confirmed_mark(model.data[index].isprocess)
    ],
  );
}
