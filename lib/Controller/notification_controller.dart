import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/Controller/scheduler_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class NotificationController {
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    //init settings for android
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("hattab");

    //request permission for android
    await notificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission() ??
        false;
    //request permission for ios
    await notificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
                alert: true, badge: true, sound: true, critical: true) ??
        false;

    //init settings for ios
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    //init settings for both os
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {});
  }

  Future notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max,
            visibility: NotificationVisibility.public),
        iOS: DarwinNotificationDetails());
  }

  //send the notification function
  Future showNotifications(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  //function to send notification in the specified recharge date
  Future<void> showScheduledNotifications(
      {int id = 0, String? title, String? body, String? payload}) async {
    tz.TZDateTime scheduledDate =
        await SchedulerController().getDateFromStorage();

    log(
      "howde $scheduledDate",
    );
    try {
      return notificationsPlugin.zonedSchedule(
          0, title, body, scheduledDate, await notificationDetails(),
          // ignore: deprecated_member_use
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {
      log(e.toString());
    }
  }

  Future showmy(
      {int id = 0, String? title, String? body, String? payload}) async {
    await notificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.everyMinute,
      await notificationDetails(),
    );
  }
}
