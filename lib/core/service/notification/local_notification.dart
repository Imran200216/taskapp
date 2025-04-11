import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  /// Flutter Local Notifications Plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize Notification Service
  Future<void> init() async {
    /// Initialize Timezones (once)
    tz.initializeTimeZones();

    /// Android Initialization Settings
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    /// iOS Initialization Settings
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    /// Combined Initialization Settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    /// Create Notification Channel (for Android 8.0+)
    const AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
          "channel_Id", // same as in your NotificationDetails
          "channel_Name",
          description: "This channel is used for task notifications.",
          importance: Importance.high,
        );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);

    /// Initialize Plugin
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveNotificationResponse,
    );

    /// Request Notification Permission (Android 13+)
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  /// Show Instant Notification
  Future<void> showInstantNotification(String title, String body) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  /// Show a Scheduled Notification
  Future<void> scheduledNotification(
    String title,
    String body,
    DateTime scheduleDate,
  ) async {
    final location = tz.getLocation('Asia/Kolkata');
    final scheduledTime = tz.TZDateTime.from(scheduleDate, location);

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      scheduledTime,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  /// Handles Notification Click Events
  Future<void> _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    // Handle notification click (e.g., navigate to screen)
    print("Notification clicked with payload: ${notificationResponse.payload}");
  }
}
