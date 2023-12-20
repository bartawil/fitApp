import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/notification_bloc/notification_bloc.dart';
import 'package:flutter_demo/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:flutter_demo/components/pick_image.dart';
import 'package:flutter_demo/screens/notifications/create_notification_screen.dart';
import 'package:flutter_demo/screens/notifications/notification_settings_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notification_repository/notification_repository.dart';

/// The `SettingsScreen` widget provides a user interface for managing user settings.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<MyUserBloc>().state.user!.picture = state.userImage;
          });
        }
      },
      child: Scaffold(
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
        body: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            if (state.user != null) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Settings",
                        style: GoogleFonts.caveat(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  BlocBuilder<MyUserBloc, MyUserState>(
                    builder: (context, state) {
                      if (state.user != null) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          margin: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 8.0),
                          child: ListTile(
                            leading: state.user!.picture == ""
                                ? GestureDetector(
                                    onTap: () async {
                                      await pickAndCropImage(context);
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          shape: BoxShape.circle),
                                      child: Icon(CupertinoIcons.person,
                                          color: Colors.grey.shade400),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      await pickAndCropImage(context);
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                state.user!.picture!,
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                            title: Text(
                                "${state.user!.firstName} ${state.user!.lastName}"),
                            subtitle: const Text("Edit your profile"),
                            onTap: () {},
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          margin: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 8.0),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () async {
                                await pickAndCropImage(context);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle),
                                child: Icon(CupertinoIcons.person,
                                    color: Colors.grey.shade400),
                              ),
                            ),
                            title: const Text("Profile"),
                            subtitle: const Text("Edit your profile"),
                            onTap: () {},
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0),
                    child: ListTile(
                      leading: const Icon(Icons.notification_add_rounded),
                      title: const Text("Create Notifications"),
                      onTap: () {
                        Navigator.push( 
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                BlocProvider<NotificationBloc>(
                              create: (context) => NotificationBloc(
                                  notificationRepository: FirebaseNotificationRepository()),
                              child: CreateNotificationScreen(state.user!.id),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0),
                    child: ListTile(
                      leading: const Icon(Icons.notifications_off),
                      title: const Text("Notifications Settings"),
                      onTap: () {
                        Navigator.push( 
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                BlocProvider<NotificationBloc>(
                              create: (context) => NotificationBloc(
                                  notificationRepository: FirebaseNotificationRepository()),
                              child: const NotificationSettingsScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
