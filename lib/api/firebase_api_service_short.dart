import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toilet_admin/api/firebase_api_service.dart';
import 'package:toilet_admin/api/my_api_service.dart';
import 'package:toilet_admin/feedback_noti_detail.dart';
import 'package:toilet_admin/main.dart';
import 'package:toilet_admin/utils/generate_randomstring.dart';

class FirebaseApiShort {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // late FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    _saveDeviceToken();
     initLocalNotifications();
    initPushNotification();
   
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getNotificationSettings();
    FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? value) async {
      debugPrint('getInitialMessage');
      if (value != null) {
        handleBackGroundMessage(value);
      }
    });
    FirebaseMessaging.onMessageOpenedApp
        .listen(handleBackGroundMessage)
        .onDone(() {
      debugPrint('onMessageOpenedApp : DONE');
    });
    FirebaseMessaging.onBackgroundMessage((message) {
      debugPrint('onBackgroundMessage : DONE');
      return handleBackGroundMessage(message);
    });
    // FirebaseMessaging.onBackgroundMessage(functionPlaySound);

    FirebaseMessaging.onMessage.listen((event) async {
      debugPrint('onMessage : DONE');
      final notification = event.notification;
      if (notification == null) return;
      if (Platform.isAndroid) {
        // print('Local Notification Android');
      } else if (Platform.isIOS) {
        // print('Local Notification IOS');
      }
    }).onDone(() {});
  }

  Future<void> handleBackGroundMessage(
    RemoteMessage message,
  ) async {
    debugPrint("handleBackGroundMessage PROCESS");
    if (message == null) return;
    if (message.messageId != "") {
      debugPrint(
          "Have received a background message! Will have to grab the message from here somehow if the user didn't interact with the system tray message link");
    }
    debugPrint(
        'Notification received in the background.'); // Add this print statement
    navigatorKey.currentState
        ?.pushNamed(FeedbackPageDetailNotification.route, arguments: message);
  }

  Future<String?> _saveDeviceToken() async {
    if (Platform.isIOS) {
      debugPrint('_saveDeviceToken iOS');
      // FirebaseMessaging.instance.requestPermission();
    } else if (Platform.isAndroid) {
      debugPrint('_saveDeviceToken Android');
    }
    String? deviceToken = '@';
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      debugPrint('could not get device token $e');
    }
    if (deviceToken != null) {
      debugPrint(deviceToken);
    }
    final serviceApi = MyAPIService();
    serviceApi.saveToken(value: deviceToken, name: generateRandomString(10));
    return deviceToken;
  }
}

Future<void> initLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(ICON_LAUNCHER);
  const DarwinInitializationSettings darwinInitializationSettings =
      DarwinInitializationSettings(
    defaultPresentSound: true,
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentBanner: true,
    defaultPresentList: true,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: darwinInitializationSettings);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: (details) async {
      print('onDidReceiveBackgroundNotificationResponse');
    },
    onDidReceiveNotificationResponse: (details) async {
      print('onDidReceiveNotificationResponse');
    },
  );
}

Future<void> showNotificationWithSound(String title, String body) async {
  const AndroidNotificationDetails android = AndroidNotificationDetails(
    CHANEL_ID,
    CHANEL_NAME,
    importance: Importance.max,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound(
        'iphone_notification.mp3'), // Replace with your sound file
    // sound: RawResourceAndroidNotificationSound('iphone_notification.mp3'), // Replace with your sound file
  );
  const DarwinNotificationDetails ios = DarwinNotificationDetails(
      sound: 'iphone_notification.aiff',
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentList: true,
      presentSound: true); // Replace with your sound file
  const NotificationDetails platform =
      NotificationDetails(android: android, iOS: ios);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platform,
    payload: 'iphone_notification',
  );
}
