import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('app_badge_channel');

Future<void> setAppBadgeNumber(int badgeNumber) async {
  try {
    await _channel.invokeMethod('setAppBadgeNumber', badgeNumber);
  } on PlatformException catch (e) {
    print('Error setting badge number: ${e.message}');
  }
}