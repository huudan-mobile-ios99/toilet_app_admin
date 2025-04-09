import 'package:flutter/material.dart';
import 'package:toilet_admin/api/my_api_service.dart';
import 'package:toilet_admin/utils/format_datetime.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';
import 'package:toilet_admin/widget/item_star.dart';
import 'package:toilet_admin/widget/item_toilet.dart';
import 'package:toilet_admin/widget/showsnackbar.dart';

class FeedbackPageDetail extends StatefulWidget {
  final Map? nObj;
  final String? dateTime;
  final int? index;
  final int? star;
  final bool? isprocess;
  final String? processCreateAt;
  final List<String>? list;
  final String? datumId;
  final VoidCallback? onBackPress;

  const FeedbackPageDetail(
      {super.key,
      this.onBackPress,
      this.nObj,
      this.datumId,
      this.processCreateAt,
      this.isprocess,
      this.dateTime,
      this.index,
      this.list,
      this.star
  });

  @override
  State<FeedbackPageDetail> createState() => _FeedbackPageDetailState();
}

class _FeedbackPageDetailState extends State<FeedbackPageDetail> {
  List<String> feedbackList = [];
  final service_api = MyAPIService();
  final format_datetime = StringFormat();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: PaddingDefault.padding32,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.redAccent.shade200,
          flexibleSpace: const Image(
            image: AssetImage('assets/background6.jpeg'),
            filterQuality: FilterQuality.low,
            fit: BoxFit.cover,
          ),
          title: text_custom(
              text: 'FEEDBACK LIST DETAIL',
              size: TextSizeDefault.text22,
              color: MyColor.white),
        ),
        body: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingDefault.padding32,
                vertical: PaddingDefault.padding16),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text_custom(
                      text: 'Feedback No: #${widget.index! + 1} ', size: 22),
                  text_custom(
                      text: 'Date & Time: ${widget.dateTime} ', size: 22),
                ],
              ),
              const SizedBox(
                height: PaddingDefault.padding24,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowStarDisplay(
                      input: widget.star ?? 0, size: PaddingDefault.padding48),
                  const SizedBox(
                    height: PaddingDefault.padding24,
                  ),
                  widget.list!.isNotEmpty
                      ? rowToiletDisplay(input: widget.list, isDetail: true)
                      : text_custom(
                          text: 'NO FEEDBACK',
                          weight: FontWeight.w600,
                          size: 16),
                  const SizedBox(
                    height: PaddingDefault.padding24,
                  ),
                  const Divider(
                    color: MyColor.grey_tab,
                  ),
                  const SizedBox(
                    height: PaddingDefault.padding24,
                  ),
                  Center(
                    child: widget.isprocess == false
                        ? ElevatedButton(
                            onPressed: () {
                              print('click submit');
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    surfaceTintColor: Colors.transparent,
                                    backgroundColor: MyColor.white,
                                    icon: const Icon(Icons.details_outlined),
                                    title: text_custom(text: 'Feedback Confirmation'),
                                    content: text_custom(text:'Confirm process feedback from staff'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: text_custom(
                                              text: "CANCEL",
                                              weight: FontWeight.w600)),
                                      TextButton(
                                          onPressed: () {
                                            print('click yes');
                                            Navigator.of(context).pop();
                                            service_api.updateFeedBackwstatus( widget.datumId).then((value) {
                                              if (value['status'] == true) {
                                                showSnackBar(context:context,message: value['message'],duncration_second: 3,onPressed: (){});
                                                Navigator.of(context).pop();
                                                widget.onBackPress!();
                                              }
                                            });
                                          },
                                          child: text_custom(
                                              text: "YES",
                                              weight: FontWeight.w600))
                                    ],
                                  );
                                },
                              );
                            },
                            child: text_custom(text: 'CONFIRM', size: 16))
                        : ElevatedButton(
                            onPressed: () {},
                            child: text_custom(
                                text: 'CONFIRMED BY STAFF ✅', size: 16)),
                  ),
                  const SizedBox(
                    height: PaddingDefault.padding24,
                  ),
                  widget.isprocess == true
                      ? Center(
                          child: text_custom(
                              text:
                                  "Confirmed Datetime: ${widget.processCreateAt}"),
                        )
                      : Container()
                ],
              )
            ])));
  }
}
