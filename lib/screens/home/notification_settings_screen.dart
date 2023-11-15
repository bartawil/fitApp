import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  DateTime dateTime = DateTime.now();
  bool repeatWeekly = false;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('playstore');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
      macOS: null,
      linux: null,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  showNotification() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      return;
    }

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "ScheduleNotification001",
      "Notify Me",
      importance: Importance.high,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: null,
      linux: null,
    );

    // // flutterLocalNotificationsPlugin.show(
    //     01, _title.text, _desc.text, notificationDetails);

    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);

     if (repeatWeekly) {
      flutterLocalNotificationsPlugin.zonedSchedule(
          01,
          titleController.text,
          descriptionController.text,
          scheduledAt,
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          payload: 'Ths s the data',
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    } else {
      flutterLocalNotificationsPlugin.zonedSchedule(
          01,
          titleController.text,
          descriptionController.text,
          scheduledAt,
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          payload: 'Ths s the data');
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        body: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Notifications List',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.playfairDisplay(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, int i) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 0.5,
                          ),
                          right: BorderSide(
                            color: Colors.grey[300]!,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: const ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0), // Increase the vertical padding.
                        trailing: Text(
                            '00',
                            style: TextStyle(fontSize: 20),
                          ),
                        title: Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  8.0), // Add padding to the bottom of the title.
                          child: Text(
                            'Title',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        subtitle: Text(
                          'Description',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
