
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:toilet_admin/api/my_api_service.dart';
import 'package:toilet_admin/utils/convert_function.dart';
import 'package:toilet_admin/utils/format_datetime.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';
import 'package:toilet_admin/widget/item_star.dart';
import 'package:toilet_admin/widget/item_toilet.dart';

class FeedbackPageDetailNotification extends StatefulWidget {
  static const route = '/feedback_detail_screen';
  final Map? nObj;
  final String? dateTime;
  final int? index;
  final int? star;
  final List<String>? list;
  const FeedbackPageDetailNotification({super.key, this.nObj, this.dateTime, this.index, this.list, this.star});

  @override
  State<FeedbackPageDetailNotification> createState() =>
      _FeedbackPageDetailNotificationState();
}

class _FeedbackPageDetailNotificationState
    extends State<FeedbackPageDetailNotification> {
  List<String> feedbackList = [];
  final service_api = MyAPIService();
  final format_datetime = StringFormat();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    //  String feedbackString = message!.data['feedback'];
    //  var ab = json.decode(feedbackString).cast<String>().toList();

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).popUntil((route) => route.isFirst);
            }, icon: const Icon(Icons.home,size: PaddingDefault.padding32,
            color: Colors.white,))
          ],
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
            image: AssetImage('assets/background5.jpeg'),
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
                  text_custom(text: 'Feedback No #: ', size: 22),
                  text_custom(
                      text: 'Date & Time: ${message!.data['datetime']}',
                      size: 22),
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
                      input: int.parse('${message.data['star']}') ?? 0,
                      size: PaddingDefault.padding40),
                  const SizedBox(
                    height: PaddingDefault.padding24,
                  ),
                  rowToiletDisplay(input:parseStringList(message.data['feedback']))
                  // text_custom(text:message.data['feedback'])
                ],
              ),
              const SizedBox(
                height: PaddingDefault.padding24,
              ),
              text_custom(
                  text: '${message.notification!.title}',
                  size: 22,
                  weight: FontWeight.w600),
              text_custom(text: '${message.notification!.body}', size: 22),
              const Divider(
                    color: MyColor.grey_tab,
                  ),
                  const SizedBox(
                    height: PaddingDefault.padding24,
                  ),
              // Center(
              //       child: ElevatedButton(
              //           onPressed: () {
              //             print('click submit');
              //             showDialog(
              //               context: context,
              //               builder: (context) {
              //                 return AlertDialog(
              //                   surfaceTintColor: Colors.transparent,
              //                   backgroundColor: MyColor.white,
              //                   icon: const Icon(Icons.details_outlined),
              //                   title: text_custom(text: 'Feedback Confirmation'),
              //                   content: text_custom(
              //                       text:'Confirm process feedback from staff'),
              //                   actions: [
              //                     TextButton(
              //                         onPressed: () {
              //                           Navigator.of(context).pop();
              //                         },
              //                         child: text_custom(
              //                             text: "CANCEL",
              //                             weight: FontWeight.w600)),
              //                     TextButton(
              //                         onPressed: () {
              //                           print('click yes');
              //                         },
              //                         child: text_custom(text: "YES", weight: FontWeight.w600))
              //                   ],
              //                 );
              //               },
              //             );
              //           },
              //           child: text_custom(text: 'CONFIRM', size: 16)),
              //     ),
                  // const SizedBox(height: PaddingDefault.padding24,),
            ])));
  }
}
