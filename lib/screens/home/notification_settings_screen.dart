import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/notification_bloc/notification_bloc.dart';
import 'package:flutter_demo/screens/home/notification_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification_repository/notification_repository.dart';

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

  List<MyNotification> notificationList = [];

  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(const GetNotificationsList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is GetNotificationsListSuccess) {
          notificationList = state.notificationList;
          setState(() {
            notificationList
                .sort((a, b) => b.serialNumber.compareTo(a.serialNumber));
          });
        } else if (state is DeleteNotificationSuccess) {
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
                                  vertical:
                                      8.0), // Increase the vertical padding.
                              
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        8.0), // Add padding to the bottom of the title.
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          BlocProvider<NotificationBloc>(
                                            create: (context) => NotificationBloc(
                                                notificationRepository:
                                                    FirebaseNotificationRepository()),
                                            child: NotificationDetailsScreen(notificationList[i]),
                                          )),
                                );
                              },
                            ),
                          );
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
