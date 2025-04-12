import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz show initializeTimeZones;
import 'package:timezone/standalone.dart' as tz;

class NotificationService {
  /// initialize the flutter local notification service
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///
  static Future<void> onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {}

  /// initialize the notification plugin
  static Future<void> init() async {
    /// define the android initialization settings
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    /// define the ios initialization settings
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    /// combine android and ios initialization settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    /// initialize the plugin with the specified settings
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveNotificationResponse,
    );

    /// request notification permission for android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  /// show an instant notification
  static Future<void> showInstantNotification(String title, String body) async {
    /// define the notification detials
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_Id",
        " channel_Name",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  /// show a scheduled notification
  static Future<void> scheduledNotification(
    String title,
    String body,
    DateTime scheduleDate,
  ) async {
    /// Ensure the timezone is initialized before using tz.local
    tz.initializeTimeZones();

    /// Get the local timezone
    final location = tz.getLocation('Asia/Kolkata');
    final scheduledTime = tz.TZDateTime.from(scheduleDate, location);

    /// Define notification details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      scheduledTime,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
