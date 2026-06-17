import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  List<Map<String, dynamic>> notifications = [
    {
      "title": "Welcome to QuickFix!",
      "body": "Thanks for signing up. Let's get started.",
      "time": "Just now",
      "read": false,
    },
    {
      "title": "Update Available",
      "body": "A new update is available. Tap to download.",
      "time": "10 mins ago",
      "read": false,
    },
    {
      "title": "Profile Updated",
      "body": "Your profile was successfully updated.",
      "time": "1 day ago",
      "read": true,
    },
  ];

  void markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification["read"] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(fontSize: width * 0.05),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: "Mark all as read",
            onPressed: markAllAsRead,
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
                "No notifications yet.",
                style: GoogleFonts.poppins(
                  fontSize: width * 0.045,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(width * 0.03),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return OpenContainer(
                  closedElevation: 0,
                  transitionType: ContainerTransitionType.fade,
                  closedBuilder: (context, openContainer) {
                    return ListTile(
                      onTap: openContainer,
                      tileColor: notification["read"]
                          ? Colors.grey[200]
                          : Colors.teal.withOpacity(0.1),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                        horizontal: width * 0.04,
                      ),
                      leading: Icon(
                        notification["read"]
                            ? Icons.notifications_none
                            : Icons.notifications_active,
                        size: width * 0.07,
                        color: notification["read"]
                            ? Colors.grey
                            : Colors.teal,
                      ),
                      title: Text(
                        notification["title"],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.045,
                          color: notification["read"]
                              ? Colors.black54
                              : Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        notification["body"],
                        style: TextStyle(fontSize: width * 0.037),
                      ),
                      trailing: Text(
                        notification["time"],
                        style: TextStyle(fontSize: width * 0.03),
                      ),
                    );
                  },
                  openBuilder: (context, _) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          notification["title"],
                          style: GoogleFonts.poppins(fontSize: width * 0.045),
                        ),
                        backgroundColor: Colors.teal,
                      ),
                      body: Padding(
                        padding: EdgeInsets.all(width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification["body"],
                              style: GoogleFonts.poppins(fontSize: width * 0.045),
                            ),
                            SizedBox(height: height * 0.03),
                            Text(
                              "Received: ${notification["time"]}",
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}