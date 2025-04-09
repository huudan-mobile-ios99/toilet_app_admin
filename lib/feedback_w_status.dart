import 'dart:async';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:toilet_admin/api/my_api_service.dart';
import 'package:toilet_admin/feedback_detail.dart';
import 'package:toilet_admin/model/feedback_model_w_status.dart';
import 'package:toilet_admin/utils/format_datetime.dart';
import 'package:toilet_admin/utils/mycolors.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';
import 'package:toilet_admin/widget/feedback_page_widget.dart/error.dart';
import 'package:toilet_admin/widget/feedback_page_widget.dart/item_feedback.dart';
import 'package:toilet_admin/widget/feedback_page_widget.dart/loading.dart';
import 'package:toilet_admin/main.dart';

class FeedbackPage2WStatus extends StatefulWidget {
  static const route = '/feedback_screen';

  final Map nObj;
  const FeedbackPage2WStatus({super.key, required this.nObj});

  @override
  State<FeedbackPage2WStatus> createState() => _FeedbackPage2WStatusState();
}

class _FeedbackPage2WStatusState extends State<FeedbackPage2WStatus>
    with RouteAware {
  List<String> feedbackList = [];
  int page = 1;
  final service_api = MyAPIService();
  final format_datetime = StringFormat();
  late Timer _timer;
  int defaultTimer = 180;
  late Future<void> _dataFuture;
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);

  //PLAY SOUND
  // late AudioPlayer audioPlayer;
  final player = AudioPlayer();
  Future<void> playSound() async {
    const String path = "iphone_notification.mp3";
    await player.play(AssetSource(path));
  }

  // Stop sound
  Future<void> stopSound() async {
    await player.stop();
  }

  @override
  void initState() {
    super.initState();
    //ROUTE OBSERVER
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });

    //AUDIO PLAYER
    // audioPlayer=AudioPlayer()..setSourceAsset("assets/iphone_notification.mp3");

    //SCROLLER REACH BOTTOM
    _scrollController.addListener(() {
      final pos = _scrollController.position;
      final triggerFetchMoreSize = 0.9 * pos.maxScrollExtent;
      if (pos.pixels > triggerFetchMoreSize) {
        Future.delayed(const Duration(seconds: 2), () {
          //   setState(() {
          //   _dataFuture = fetchData();
          // });
          print('call APIs');
        });
      }
    });

    _dataFuture = fetchData();
    _timer = Timer.periodic(Duration(seconds: defaultTimer), (Timer timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    try {
      final model = await service_api.fetchFeedBackwstatus();
      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
    // page++;
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _dataFuture = fetchData();
    });
  }

  void navigateBackPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackPageDetail(
          onBackPress: () {
            print('on back press in home');
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void didPush() {
    print('FeedbackPage: Called didPush');
    _handleRefresh();
    super.didPush();
  }

  @override
  void didPop() {
    print('FeedbackPage: Called didPop');
    _handleRefresh();
    super.didPop();
  }

  @override
  void didPopNext() {
    print('FeedbackPage: Called didPopNext');
    _handleRefresh();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print('FeedbackPage: Called didPushNext');
    super.didPushNext();
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
        actions: const [
          // TextButton(
          //     onPressed: () {
          //       debugPrint('stop sound');
          //       stopSound();
          //     },
          //     child: text_custom(text: "stop sound")),
          // TextButton(
          //     onPressed: () {
          //       debugPrint('call sound');
          //       playSound();
          //     },
          //     child: text_custom(text: "call sound", color: MyColor.white))
        ],
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
          padding: const EdgeInsets.symmetric(
              horizontal: PaddingDefault.padding24,
              vertical: PaddingDefault.padding24),
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
                future: service_api.fetchFeedBackwstatus(),
                builder: (context, snapshot) {
                  late FeedbackModelWStatus? model = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: loading_line());
                  } else if (model!.data.isEmpty) {
                    return text_custom(text: "Empty data");
                  } else if (snapshot.hasError) {
                    return error_line(_handleRefresh);
                  } else
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(0),
                      itemCount: model.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              print('id: ${model.data[index].datumId}');
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return FeedbackPageDetail(
                                    nObj: const {},
                                    index: index,
                                    datumId: model.data[index].datumId,
                                    list: model.data[index].experience,
                                    star: model.data[index].star,
                                    isprocess: model.data[index].isprocess,
                                    dateTime: format_datetime.formatDateTimeWithSplash(
                                            model.data[index].createdAt),
                                    processCreateAt: format_datetime
                                        .formatDateTimeWithSplash(
                                            model.data[index].processCreatedAt),
                                  );
                                },
                              ));
                            },
                            child: item_feedback(
                                width: width,
                                height: height,
                                index: index,
                                format_datetime: format_datetime,
                                model: model));
                      },
                    );
                },
              ),
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
