import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toilet_admin/api/my_api_service.dart';
import 'package:toilet_admin/feedback_detail.dart';
import 'package:toilet_admin/model/feedback_model.dart';
import 'package:toilet_admin/utils/format_datetime.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';
import 'package:toilet_admin/widget/item_star.dart';
import 'widget/item_toilet.dart';

class FeedbackPage extends StatefulWidget {
  static const route = '/feedback_screen';

  final Map nObj;
  const FeedbackPage({super.key, required this.nObj});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<String> feedbackList = [];
  final service_api = MyAPIService();
  final format_datetime = StringFormat();
  late Timer _timer;
  int defaultTimer = 180;
  //90 seconds
  late Future<void> _dataFuture; // Future to handle data fetching

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
    _timer = Timer.periodic(Duration(seconds: defaultTimer), (Timer timer) {
      fetchData(); // Fetch data every 60 seconds
      _showAutoRefreshToast(); // Show toast after automatic refresh
    });
  }

  void _showAutoRefreshToast() {}

  Future<void> fetchData() async {
    try {
      final model = await service_api.fetchFeedBack();
      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _dataFuture = fetchData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent.shade200,
          flexibleSpace: const Image(
            image: AssetImage('assets/background6.jpeg'),
            filterQuality: FilterQuality.low,
            fit: BoxFit.cover,
          ),
          // actions: [
          //   TextButton(
          //       onPressed: () {
          //         debugPrint('call sound');
          //       },
          //       child: text_custom(text:"call sound",color:MyColor.white))
          // ],
          title: text_custom(
              text: 'FEEDBACK LIST',
              size: TextSizeDefault.text22,
              color: MyColor.white),
        ),
        body: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background5.jpeg'),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.low)),
            // color:MyColor.bedge,
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingDefault.padding16,
                vertical: PaddingDefault.padding16),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                physics: const BouncingScrollPhysics(),
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad
                },
              ),
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: FutureBuilder(
                  future: service_api.fetchFeedBack(),
                  builder: (context, snapshot) {
                    late FeedbackModel? model = snapshot.data;

                    if (snapshot.hasError) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          text_custom(text: 'An error orcur'),
                          TextButton(
                              onPressed: _handleRefresh,
                              child: text_custom(text: "Refresh"))
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text_custom(
                              text: 'LOADING ',
                              color: MyColor.white,
                              size: TextSizeDefault.text18),
                          const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ],
                      ));
                    } else if (model!.data.isEmpty) {
                      return text_custom(text: "Empty data");
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: model.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print('print item $index');
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return FeedbackPageDetail(
                                  nObj: const {},
                                  index: index,
                                  list: model.data[index].experience,
                                  star: model.data[index].star,
                                  dateTime:
                                      format_datetime.formatDateTimeWithSplash(
                                          model.data[index].createdAt),
                                );
                              },
                            ));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: MyColor.white,
                                  borderRadius: BorderRadius.circular(
                                      PaddingDefault.padding24)),
                              margin: const EdgeInsets.only(
                                  bottom: PaddingDefault.pading12),
                              padding:
                                  const EdgeInsets.all(PaddingDefault.pading08),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: width * .065,
                                      child: text_custom(
                                          text: '#${index + 1}',
                                          size: TextSizeDefault.text32)),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: width * .7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          model.data[index].experience
                                                  .isNotEmpty
                                              ? rowToiletDisplay(
                                                  input: model
                                                      .data[index].experience)
                                              : text_custom(
                                                  text: 'NO FEEDBACK',
                                                  weight: FontWeight.w600,
                                                  size: 16),
                                          rowStarDisplay(
                                              size: PaddingDefault.padding24,
                                              input:
                                                  model.data[index].star ?? 0),
                                        ],
                                      )),
                                  Expanded(
                                      child: text_custom(
                                          size: TextSizeDefault.text16,
                                          text: format_datetime
                                              .formatDateTimeWithSplash(model
                                                  .data[index].createdAt))),
                                ],
                              )),
                        );
                      },
                    );
                  },
                ),
              ),
            )));
  }
}
