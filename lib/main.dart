import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toilet_admin/api/firebase_api_service_short.dart';
import 'package:toilet_admin/api/my_api_service.dart';
import 'package:toilet_admin/feedback_noti_detail.dart';
import 'package:toilet_admin/feedback_w_status.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late FirebaseMessaging firebaseMessaging;
Map userPayload = {};
bool pushRedirect = false;
Map pushPayload = {};
late MyAPIService service_api;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  //AUDIO
  // startAudioService();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => debugPrint('$value'));

  await FirebaseApiShort().initNotification();
  // await FirebaseApi().initNotification().then((value) => null);
  // startAudioService();
    // showDialog(
    //   context: navigatorKey.currentContext!,
    //   builder: (context) {
    //     return myDialogDisplaySound(
    //         context: navigatorKey.currentContext,
    //         onPress: () => stopAudioService());
    //   },
    // );
  runApp(const MyApp());
}

Future<void> handleBackGroundMessage(
  RemoteMessage message,
) async {
  print('handleBackGroundMessage');
  navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => FeedbackPage2WStatus(nObj: {})));
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      title: 'WC APP',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent.shade200),
        useMaterial3: true,
      ),
      home: const FeedbackPage2WStatus(
        nObj: {},
      ),
      routes: {
        FeedbackPage2WStatus.route: (context) => const FeedbackPage2WStatus(
              nObj: {},
        ),
        FeedbackPageDetailNotification.route: (context) =>
            FeedbackPageDetailNotification()
      },
    );
  }
}
