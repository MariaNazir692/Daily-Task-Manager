import 'package:daily_task_manager/model/add_task_model.dart';
import 'package:daily_task_manager/view/notification_detail/notification_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:rxdart/rxdart.dart' show BehaviorSubject;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';




class NotifyHelper{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();//
  final onNotifications=BehaviorSubject<String?>();

  Future<void> initNotification() async {
    configureLoaclTime();
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("appicon");

      final InitializationSettings initializationSettings =
      InitializationSettings(
      iOS: initializationSettingsIOS,
      android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification);

  }
  Future selectNotification(String? payload) async {
    if (payload != null) {
      if (kDebugMode) {
        print('notification payload: $payload');
      }
    } else {
      if (kDebugMode) {
        print("Notification Done");
      }
    }
    Get.to(()=>Notification_Detail(lable:payload));
  }
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future displayNotification({required String title, required String body}) async {

    print("doing test");
    //this is doing android platform specifications which require channel id, channel name, description
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Daily_task',
        'Daily Task Manager',
        'Daily Task Manager Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
        icon: 'appicon',
       additionalFlags: Int32List.fromList(<int>[4]),
       fullScreenIntent: true,

    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics,
        payload: 'Default_Sound',
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }
  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    Get.dialog(Text("Welcome to Task Manager"));
  }
  Future<void> scheduledNotification(int hour, int minutes, TaskModel task) async {
    await Future.delayed(Duration(seconds: 10));
     flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt(),
        task.title,
        task.note,
      convertTime(hour, minutes),
      //  tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
         const NotificationDetails(
            android: AndroidNotificationDetails('Daily_task',
                'Daily Task Manager', 'Daily Task Manager Notification Channel',
                importance: Importance.max,
                priority: Priority.max,
                icon: "appicon",
              playSound: true,
              autoCancel: true,

            )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
       payload: "${task.title}|"+"${task.note}|",

     );

  }

  tz.TZDateTime convertTime(int hour, int minutes){
    final tz.TZDateTime now=tz.TZDateTime.now(tz.local);
    tz.TZDateTime schedualeDate=tz.TZDateTime(tz.local,now.year, now.month, now.day, hour, minutes);
    if(schedualeDate.isBefore(now)){
      schedualeDate=schedualeDate.add(const Duration(seconds:5));
    }
    return schedualeDate;
  }

  Future<void> configureLoaclTime()async{
    tz.initializeTimeZones();
    final String timeZone=await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));

  }
}