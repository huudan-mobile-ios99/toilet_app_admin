import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toilet_admin/api/my_api_service.dart';
import 'package:toilet_admin/model/feedback_model_w_status.dart';
import 'package:toilet_admin/utils/format_datetime.dart';
import 'package:toilet_admin/utils/padding.dart';
import 'package:toilet_admin/utils/text.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});
  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  List<String> feedbackList = [];
  final service_api = MyAPIService();
  final format_datetime = StringFormat();
  late Timer _timer;
  int defaultTimer = 180;
  //180 seconds
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
    _timer = Timer.periodic(Duration(seconds: defaultTimer), (Timer timer) {
      fetchData();
      fetchData();
      _showAutoRefreshToast();
    });
  }

  void _showAutoRefreshToast() {}

  Future<void> fetchData() async {
    try {
      final model = await service_api.fetchFeedBackwstatus();
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
                    if (snapshot.hasError) {
                      return text_custom(text: 'An error orcur');
                    } else if (snapshot.connectionState ==ConnectionState.waiting) {
                      return const Center(
                          child:  CircularProgressIndicator(
                            color: Colors.white,
                          ),);
                    } else if (model!.data.isEmpty) {
                      return text_custom(text: "Empty data");
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: model.data.length,
                      itemBuilder: (context, index) {
                        return text_custom(text:model.data[index].content);
                      },
                    );
                  },
                ),
              ),
            )));
  }
}
