import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toilet_admin/feedback_noti_detail.dart';
import 'package:toilet_admin/main.dart';

const CHANEL_ID = 'high_importance_chanel';
const CHANEL_NAME = 'High Importance Notifications';
const CHANEL_DESC = 'this channel is used for important notification';
const ICON_LAUNCHER = '@drawable/ic_launcher';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  late final BuildContext? context;

  final _androidChannel = const AndroidNotificationChannel(
    CHANEL_ID,
    CHANEL_NAME,
    description: CHANEL_DESC,
    playSound: true,
    importance: Importance.defaultImportance,
  );
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // await _firebaseMessaging.requestPermission();
    _saveDeviceToken();
    // initPushNotification();
    initLocalNotifications();
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getNotificationSettings();

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? value) {
      print('getInitialMessage');
      if (value != null) {
        print('value not null');
        handleBackGroundMessage(value);
      }
    });
    FirebaseMessaging.onMessageOpenedApp
        .listen(handleBackGroundMessage)
        .onDone(() {
      print('onMessageOpenedApp : DONE');
    });
    FirebaseMessaging.onBackgroundMessage(handleBackGroundMessage);

    // FirebaseMessaging.onMessage.listen((event) {
    //   final notification = event.notification;
    //   if (notification == null) return;

    //   if (Platform.isAndroid) {
    //     // Local Notification Code to Display Alert
    //     print('Local Notification Android');
    //     // displayNotification(event);
    //   } else if (Platform.isIOS) {
    //     print('Local Notification IOS');
    //     // displayNotification(event);
    //     handleBackGroundMessage(event);
    //   }
    // }).onDone(() {
    //   print('onMessage : onDone');
    // });
  }

  Future<void> handleBackGroundMessage(
    RemoteMessage message,
  ) async {
    print('asset noti on BG');
    print('title onBG : ${message.notification!.title}');
    print('sub-title onBG: ${message.notification!.body}');
    print('payload onBG; ${message.data}');
    // ignore: unnecessary_null_comparison
    if (message == null) return;

    // _localNotifications.show(
    //   message.hashCode,
    //   message.notification!.title!,
    //   message.notification!.body!,
    //   NotificationDetails(
    //     iOS: DarwinNotificationDetails(
    //       badgeNumber: message.data.length,
    //       sound: 'assets/iphone_notification.aiff',
    //       presentBadge: true,
    //       presentAlert: true,
    //       presentSound: true,
    //       presentBanner: true,
    //       presentList: true,
    //     ),
    //     android: AndroidNotificationDetails(
    //       _androidChannel.id,
    //       _androidChannel.name,
    //       sound: RawResourceAndroidNotificationSound('iphone_notification.mp3'),
    //       channelDescription: _androidChannel.description,
    //       icon: '$ICON_LAUNCHER',
    //     ),
    //   ),
    //   payload: jsonEncode(message.toMap()),
    // );

    navigatorKey.currentState
        ?.pushNamed(FeedbackPageDetailNotification.route, arguments: message);
  }

  Future initLocalNotifications() async {
    print('clickl noti from :initLocalNotifications ');

    const android = AndroidInitializationSettings(ICON_LAUNCHER);
    const ios = DarwinInitializationSettings(
      defaultPresentSound: true,
    );
    const settings = InitializationSettings(android: android, iOS: ios);
    await _localNotifications.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: (details) async {
        print('onDidReceiveBackgroundNotificationResponse');
        final message = RemoteMessage.fromMap(jsonDecode(details as String));
        await handleBackGroundMessage(message);
      },
      onDidReceiveNotificationResponse: (details) async {
        print('onDidReceiveNotificationResponse');
        final message = RemoteMessage.fromMap(jsonDecode(details as String));
        await handleNotificationResponse(message);
      },

     
    );
     // Show a test notification when initializing
      await showTestNotification();

    final platForm = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platForm?.createNotificationChannel(_androidChannel);
  }


  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // Handle the background message here, e.g., navigate to a specific screen
    print('Handling background message: ${message.notification?.title}');
    print('payload: ${message.data}');
    // navigateToScreen();
  }

  Future<void> handleNotificationResponse(RemoteMessage message) async {
    // Handle the notification response here, e.g., navigate to a specific screen
    print('payload: ${message.data}');
    // navigateToScreen();
  }

 Future<void> showTestNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      CHANEL_ID,
      CHANEL_NAME,
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('iphone_notification.mp3'), // Replace with your sound file
      // sound: RawResourceAndroidNotificationSound('iphone_notification.mp3'), // Replace with your sound file
    );
    const DarwinNotificationDetails ios = DarwinNotificationDetails(sound: 'iphone_notification.aiff',presentAlert: true,presentBadge: true,presentBanner: true,presentList: true,presentSound: true); // Replace with your sound file
    // const DarwinNotificationDetails ios = DarwinNotificationDetails(sound: 'iphone_notification.aiff',presentAlert: true,presentBadge: true,presentBanner: true,presentList: true,presentSound: true); // Replace with your sound file
    const NotificationDetails platform = NotificationDetails(android: android, iOS: ios);

    await _localNotifications.show(
      0,
      'Test Notification',
      'This is a test notification',
      platform,
      payload: 'iphone_notification',
      
    );
  }

  Future<String?> _saveDeviceToken() async {
    if (Platform.isIOS) {
      print('Running on iOS');
      FirebaseMessaging.instance.requestPermission();
    } else if (Platform.isAndroid) {
      print('Running on Android');
    }
    String? deviceToken = '@';
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print('could not get device token');
      print('$e');
    }

    if (deviceToken != null) {
      print(deviceToken);
    }
    return deviceToken;
  }

  //DISPLAY NOTIFICATION
  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(CHANEL_ID, CHANEL_NAME,
            channelDescription: CHANEL_DESC,
            // sound: RawResourceAndroidNotificationSound(_sound),
            importance: Importance.max,
            priority: Priority.high),
      );

      await _localNotifications.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: json.encode(message.data));
    } on Exception catch (e) {
      print(e);
    }
  }
  //END DISPLAY NOTIFICATION

  //OPEN NOTIFICATION
  void openNotification(Map payloadObj) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print('open page');
    // navigatorKey.currentState?.pushNamed(FeedbackPageDetail.route, arguments: message);

    // try {
    //   if (payloadObj.isNotEmpty) {
    //     switch (payloadObj["page"] as String? ?? "") {
    //       case "detail":
    //         navigatorKey.currentState?.push(MaterialPageRoute(
    //             builder: (context) => FeedbackPageDetail(
    //                   nObj: payloadObj,
    //                   dateTime: '',
    //                   index: 0,
    //                   list: const [],
    //                   star: 0,
    //                 )));
    //         break;
    //       case "data":
    //         navigatorKey.currentState?.push(MaterialPageRoute(
    //             builder: (context) => FeedbackPage(nObj: payloadObj)));
    //         break;
    //       default:
    //     }
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }
  //END OPEN NOTIFICATION
}
