
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'cache_helper/cache_helper.dart';
import 'cache_helper/cache_values.dart';

class PushNotificationService {
  final _fcm = FirebaseMessaging.instance;
  String? fCMToken;

  Future<void> initializeNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _fcm.requestPermission();
    await _fcm.getAPNSToken();
    fCMToken = await _fcm.getToken();
    await CacheHelper.saveData(key: CacheKeys.deviceToken, value: fCMToken);
    debugPrint("FCM Token : $fCMToken");
  }
}
