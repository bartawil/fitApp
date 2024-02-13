import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/blocs/notification_bloc/notification_bloc.dart';
import 'package:fitapp/components/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Define a Flutter StatefulWidget for creating notifications
class CreateNotificationScreen extends StatefulWidget {
  final String userId;
  const CreateNotificationScreen(this.userId, {super.key});

  @override
  State<CreateNotificationScreen> createState() =>
      _CreateNotificationScreenState();
}

// Define the state class for the CreateNotificationScreen
class _CreateNotificationScreenState extends State<CreateNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  // Initialize controllers for input fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // Initialize variables for date and time
  DateTime dateTime = DateTime.now();
  bool repeatWeekly = false;

  // Initialize notification-related variables
  int counter = 0;
  late MyNotification notification;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // Initialize notification object and set user ID
    notification = MyNotification.empty;
    notification.userId = widget.userId;

    // Initialize FlutterLocalNotificationsPlugin
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

    // Fetch notification size from NotificationBloc
    context.read<NotificationBloc>().add(const GetNotificationsSize());
    super.initState();
  }

  // Function to show a notification
  showNotification() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        dateController.text.isEmpty ||
        timeController.text.isEmpty) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

    // Define notification details for Android and iOS
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

    // Initialize time zones and schedule the notification
    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);
    final DateTime scheduledDateTime = DateTime(
      scheduledAt.year,
      scheduledAt.month,
      scheduledAt.day,
      scheduledAt.hour,
      scheduledAt.minute,
      scheduledAt.second,
      scheduledAt.millisecond,
    );

    setState(() {
      notification.title = titleController.text;
      notification.description = descriptionController.text;
      notification.scheduledAt = scheduledDateTime;
      notification.repeatWeekly = repeatWeekly;
      notification.serialNumber = counter.toDouble();
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
          payload: 'This is the data',
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
          payload: 'This is the data');
    }
    
    // Dispatch a CreateNotification event to NotificationBloc
    context.read<NotificationBloc>().add(CreateNotification(notification));

    // Clear input fields and reset variables after creating the notification
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    timeController.clear();
    setState(() {
      dateTime = DateTime.now();
      repeatWeekly = false;
    });

    // Fetch notification size from NotificationBloc again
    context.read<NotificationBloc>().add(const GetNotificationsSize());

    // Close the current screen
    Navigator.of(context).pop();
  }

  // Function to cancel a scheduled notification by ID
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  @override
  void dispose() {
    // Dispose of the text controllers when the screen is closed
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        // Listen to the NotificationBloc for GetNotificationsSizeSuccess events
        if (state is GetNotificationsSizeSuccess) {
          counter = state.size.toInt();
        }
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
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 150,),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Input field for notification title
                            TextFormField(
                              controller: titleController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                label: const Text("Notification Title"),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill in this field';
                                } else if  (value.length > 30) {
                                  return 'Please enter a shorter title';
                                } else if (specialCharRexExp.hasMatch(value)) {
                                  return 'Please enter a valid title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Input field for notification description
                            TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                label: const Text("Notification Description"),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill in this field';
                                } else if  (value.length > 30) {
                                  return 'Please enter a shorter title';
                                } else if (specialCharRexExp.hasMatch(value)) {
                                  return 'Please enter a valid description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Input field for notification date
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
                            // Input field for notification time
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
                                      final TimeOfDay? selectedTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());
                          
                                      if (selectedTime == null) {
                                        return;
                                      }
                          
                                      timeController.text =
                                          "${selectedTime.hour}:${selectedTime.minute}";
                          
                                      DateTime newDT = DateTime(
                                        dateTime.year,
                                        dateTime.month,
                                        dateTime.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );
                                      setState(() {
                                        dateTime = newDT;
                                      });
                                    },
                                  ),
                                  label: const Text("Time")),
                            ),
                            // Checkbox for repeating the notification weekly
                            CheckboxListTile(
                              title: const Text('Repeat every week'),
                              value: repeatWeekly,
                              onChanged: (bool? value) {
                                setState(() {
                                  repeatWeekly = value ?? false;
                                });
                              },
                              contentPadding:
                                  const EdgeInsets.only(left: 5.0, right: 100.0),
                            ),
                            // Button to create the notification
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  minimumSize: const Size(double.infinity, 55),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    showNotification();
                                  }
                                },
                                child: Text(
                                  "Create Notification",
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900),
                                )),
                          ],
                        ),
                      ),
                    ),
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
