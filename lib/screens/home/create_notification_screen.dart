import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/notification_bloc/notification_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:notification_repository/notification_repository.dart';

class CreateNotificationScreen extends StatefulWidget {
  final String userId;
  const CreateNotificationScreen(this.userId, {super.key});

  @override
  State<CreateNotificationScreen> createState() =>
      _CreateNotificationScreenState();
}

class _CreateNotificationScreenState extends State<CreateNotificationScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  DateTime dateTime = DateTime.now();
  bool repeatWeekly = false;

  int counter = 0;
  late MyNotification notification;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    notification = MyNotification.empty;
    // TO-DO: Get the user id from the auth state
    notification.userId = widget.userId;
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

    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);

    setState(() {
      notification.title = titleController.text;
      notification.description = descriptionController.text;
      notification.scheduledAt = scheduledAt;
      notification.repeatWeekly = repeatWeekly;
    });

    if (repeatWeekly) {
      flutterLocalNotificationsPlugin.zonedSchedule(
          counter,
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
          counter,
          titleController.text,
          descriptionController.text,
          scheduledAt,
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          payload: 'Ths s the data');
    }
    context.read<NotificationBloc>().add(CreateNotification(notification));

    // clear all the text fields after the notification is created
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
    setState(() {
      dateTime = DateTime.now();
      repeatWeekly = false;
    });
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: GestureDetector(
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
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        label: const Text("Notification Title"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        label: const Text("Notification Description"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          suffixIcon: InkWell(
                            child: const Icon(Icons.date_range),
                            onTap: () async {
                              final DateTime? newlySelectedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate: dateTime,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2095),
                              );

                              if (newlySelectedDate == null) {
                                return;
                              }

                              setState(() {
                                dateTime = newlySelectedDate;
                                dateController.text =
                                    "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                              });
                            },
                          ),
                          label: const Text("Date")),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      controller: timeController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          suffixIcon: InkWell(
                            child: const Icon(
                              Icons.timer_outlined,
                            ),
                            onTap: () async {
                              final TimeOfDay? slectedTime =
                                  await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());

                              if (slectedTime == null) {
                                return;
                              }

                              timeController.text =
                                  "${slectedTime.hour}:${slectedTime.minute}";

                              DateTime newDT = DateTime(
                                dateTime.year,
                                dateTime.month,
                                dateTime.day,
                                slectedTime.hour,
                                slectedTime.minute,
                              );
                              setState(() {
                                dateTime = newDT;
                              });
                            },
                          ),
                          label: const Text("Time")),
                    ),
                    CheckboxListTile(
                      title: const Text('Repeat every week'),
                      value: repeatWeekly,
                      onChanged: (bool? value) {
                        setState(() {
                          repeatWeekly = value ?? false;
                        });
                      },
                      contentPadding:
                          const EdgeInsets.only(left: 0.0, right: 100.0),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 55),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: showNotification,
                        child: const Text("Create Notification")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
