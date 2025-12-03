import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static onDidReceiveBackgroundNotificationResponse(
    final NotificationResponse details,
  ) {}

  //=============================init Notification
  static Future<void> init() async {
    final InitializationSettings initializationSettings =
        const InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          iOS: DarwinInitializationSettings(),
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()!
        .requestNotificationsPermission();

    //init Time zone
    tz.initializeTimeZones();
  }

  //==================================showbasicNotification
  static Future<void> showBasicNotification({
    required final String title,
    required final String body,
    required final int id,
    final String? payload,
  }) async {
    final NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id",
        "basicNotification ",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  //==========================================RepaetNotivication
  static Future<void> showRepeatedNotification({
    required final String title,
    required final String body,
    required final int id,
    final String? payload,
    required final RepeatInterval repeatInterval,
  }) async {
    final NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id",
        "basicNotificationrepaet ",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
      payload: payload,
    );
  }

  //=====================================Cancel Notification
  static void canclNotificaton(final int id) async =>
      await flutterLocalNotificationsPlugin.cancel(id);

  //=============================scheduleNotification
  static Future<void> scheduleNotification({
    required final String title,
    required final String body,
    required final int id,
    final String? payload,
  }) async {
    final NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        "id",
        "Schedule",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    final TimezoneInfo currentTimeZone =
        await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));

    //add Time zone
    final tZDateTimeAfter = tz.TZDateTime.now(
      tz.local,
    ).add(const Duration(seconds: 10));

    final tZDateTime = tz.TZDateTime(tz.local, 2025, 12, 3, 3, 41);
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tZDateTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }
}
