import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/blocs/notification_bloc/notification_bloc.dart';
import 'package:fitapp/screens/notifications/notification_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification_repository/notification_repository.dart';

// Define a StatefulWidget for managing notification settings
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

// Define the state class for the NotificationSettingsScreen
class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  // Initialize controllers for input fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // Initialize a list to store notification objects
  List<MyNotification> notificationList = [];

  @override
  void initState() {
    super.initState();
    // Fetch the list of notifications from NotificationBloc
    context.read<NotificationBloc>().add(const GetNotificationsList());
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
        if (state is GetNotificationsListSuccess) {
          // Update the notification list and sort it by serial number
          notificationList = state.notificationList;
          setState(() {
            notificationList
                .sort((a, b) => b.serialNumber.compareTo(a.serialNumber));
          });
        } else if (state is DeleteNotificationSuccess) {
          // Update the notification list after deleting a notification
          notificationList = state.notificationList;
          setState(() {
            notificationList
                .sort((a, b) => b.serialNumber.compareTo(a.serialNumber));
          });
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
                    itemCount: notificationList.length,
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
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0), 

                          title: Padding(
                            padding: const EdgeInsets.only(
                                bottom:
                                    8.0), 
                            child: Text(
                              notificationList[i].title,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          subtitle: Text(
                            notificationList[i].description,
                            style: const TextStyle(fontSize: 14),
                          ),
                          onTap: () {
                            // Navigate to NotificationDetailsScreen with the selected notification
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    BlocProvider<NotificationBloc>(
                                  create: (context) => NotificationBloc(
                                      notificationRepository:
                                          FirebaseNotificationRepository()),
                                  child: NotificationDetailsScreen(
                                      notificationList[i]),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
