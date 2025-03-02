import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController =
      StreamController();

  static onTapNotification(NotificationResponse notificationResponse) async {
    streamController.add(notificationResponse);
  }

  //  initialize
  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // عند الضغط على الاشعار يتم استخدام هذا الكود والتطبيق شغال
      onDidReceiveNotificationResponse: onTapNotification,
      // عند الضغط على الاشعار يتم استخدام هذا الكود والتطبيق مغلق
      onDidReceiveBackgroundNotificationResponse: onTapNotification,
    );
  }

  // basic Notification
  static Future<void> showBasicNotification(
      {
      required String title,
      required String body,
      required String payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      5,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // repeated Notification  to one hours
  static Future<void> showRepeatedNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id2',
      'your channel name2',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // exactAllowWhileIdle جدولة دقيقة حتى أثناء وضع السكون (الأكثر موثوقية).
    //exact جدولة دقيقة، لكن قد لا يعمل في وضع السكون.
    //inexact  جدولة غير دقيقة، قد يتأخر الإشعار بسبب تحسينات البطارية.
    AndroidScheduleMode androidScheduleMode =
        AndroidScheduleMode.exactAllowWhileIdle;
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'repeated title',
      'plain body',
      // to every minute
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      payload: 'item x',
      androidScheduleMode: androidScheduleMode,
    );
  }

  // cancel Notification
  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // scheduled Notification
  static Future<void> showScheduledNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id3',
      'your channel name3',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    // initialize the timezone to known time person
    tz.initializeTimeZones();

    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    AndroidScheduleMode androidScheduleMode =
        AndroidScheduleMode.exactAllowWhileIdle;
    UILocalNotificationDateInterpretation
        uiLocalNotificationDateInterpretation =
        UILocalNotificationDateInterpretation.absoluteTime;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'scheduled title',
      'plain body',
      tz.TZDateTime(
        tz.local,
        2025,
        2,
        22,
        12,
        57,
      ),
      // لو عاوز بعد مده معينه
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      uiLocalNotificationDateInterpretation:
          uiLocalNotificationDateInterpretation,
      platformChannelSpecifics,
      payload: 'item x',
      androidScheduleMode: androidScheduleMode,
    );
  }

  // daily scheduled Notification
  static Future<void> showDailyScheduledNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id4',
      'your channel name4',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    // initialize the timezone to known time person
    tz.initializeTimeZones();

    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var currentTime = tz.TZDateTime.now(tz.local);

    var scheduleTime = tz.TZDateTime(
        tz.local, currentTime.year, currentTime.month, currentTime.day, 9);

    if (scheduleTime.isBefore(currentTime)) {
      log(scheduleTime.day.toString());
      scheduleTime = scheduleTime.add(const Duration(days: 1));
      log(scheduleTime.day.toString());
    } else {
      log(currentTime.day.toString());
      log(currentTime.minute.toString());
    }
    AndroidScheduleMode androidScheduleMode =
        AndroidScheduleMode.exactAllowWhileIdle;
    UILocalNotificationDateInterpretation
        uiLocalNotificationDateInterpretation =
        UILocalNotificationDateInterpretation.absoluteTime;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      'scheduled title',
      'plain body',
      scheduleTime,
      // لو عاوز بعد مده معينه
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      uiLocalNotificationDateInterpretation:
          uiLocalNotificationDateInterpretation,
      platformChannelSpecifics,
      payload: 'item x',
      androidScheduleMode: androidScheduleMode,
    );
  }
}
