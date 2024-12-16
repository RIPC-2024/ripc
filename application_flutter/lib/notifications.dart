import "package:flutter_local_notifications/flutter_local_notifications.dart";

class FlutterLocalNotification {
  FlutterLocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher_car');

    DarwinInitializationSettings iosInitializationSettings =
      const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.max,
          showWhen: false,
          icon : 'ic_directions_car',
        );

    const NotificationDetails notificationDetails =
        NotificationDetails(
          android: androidNotificationDetails,
          iOS: DarwinNotificationDetails(
            badgeNumber: 1
          )
        );

    await flutterLocalNotificationsPlugin.show(
        1, 'Title', 'body', notificationDetails);
  }

  static Future<void> showNotificationAfterDelay() async {
    await Future.delayed(Duration(seconds: 3));
    await showNotification();
  }
}


