import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/home/create_notification_screen.dart';
import 'package:flutter_demo/screens/home/notification_settings_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0), 
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0), 
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Create Notifications"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const CreateNotificationScreen();
                  }),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0), 
            child: ListTile(
              leading: const Icon(Icons.notifications_off),
              title: const Text("Notifications Settings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const NotificationSettingsScreen();
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}