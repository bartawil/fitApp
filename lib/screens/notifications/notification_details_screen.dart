// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/blocs/notification_bloc/notification_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:notification_repository/notification_repository.dart';

// Define a StatefulWidget for displaying notification details
// ignore: must_be_immutable
class NotificationDetailsScreen extends StatefulWidget {
  MyNotification notification;

  // Constructor for the NotificationDetailsScreen
  NotificationDetailsScreen(this.notification, {super.key});

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

// Define the state class for the NotificationDetailsScreen
class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

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
  }

  // Function to cancel a scheduled notification by ID
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    // Dispatch a DeleteNotification event to NotificationBloc
    context
        .read<NotificationBloc>()
        .add(DeleteNotification(widget.notification.notificationId));
    // Close the NotificationDetailsScreen
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Convert scheduled time to local time and format it
    DateTime scheduledTime = widget.notification.scheduledAt.toUtc();
    DateTime localTime = scheduledTime.add(const Duration(hours: 4));
    String formattedTime = DateFormat('dd/M/yy HH:mm').format(localTime);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(
              top: 100, left: 16, right: 16, bottom: 180),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Notification Details",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                "Title:  ${widget.notification.title}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                "Description:  ${widget.notification.description}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                "Scheduled Time: $formattedTime",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                "Weekly Repeat:  ${(widget.notification.repeatWeekly == false) ? "No" : "Yes"}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                "ID:  ${widget.notification.serialNumber.toInt()}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      // Floating action button for deleting the notification
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          cancelNotification(widget.notification.serialNumber.toInt());
        },
        child: const Icon(Icons.delete),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
