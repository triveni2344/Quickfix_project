
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:users/bookingscreen.dart';
// import 'package:users/categories.dart';
// import 'package:users/homescreen.dart';
// import 'package:users/models/data.dart';
// import 'package:users/profile.dart';
// import 'package:users/saved.dart';

import 'package:quickfix_project/bookingscreen.dart';
import 'package:quickfix_project/categories.dart';
import 'package:quickfix_project/homescreen.dart';
import 'package:quickfix_project/models/data.dart';
import 'package:quickfix_project/profile.dart';
import 'package:quickfix_project/saved.dart';
// void main() {
//   if (kIsWeb) {
//     runApp(DevicePreview(builder: (context) => const MyApp()));
//   } else {
//     runApp(const MyApp());
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'QUICK FIX',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.white,
//         primarySwatch: Colors.teal,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       home: const HomePage(),
//     );
//   }
// }

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  int _currentIndex = 0;
  final List<Profile> _profiles = profilesData;

  // Handles saving/bookmarking a profile
  void _toggleSave(String profileId) {
    setState(() {
      final profile = _profiles.firstWhere((p) => p.id == profileId);
      profile.isSaved = !profile.isSaved;
    });
  }

  // Handles adding a profile to the cart after booking
  void _confirmBooking(String profileId) {
    setState(() {
      final profile = _profiles.firstWhere((p) => p.id == profileId);
      profile.isBooked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pass the state and callbacks down to the relevant screens
    final List<Widget> screens = [
      // THIS IS THE CORRECTED PART
      HomeScreen(
        onToggleSave: _toggleSave,
        onConfirmBooking: _confirmBooking,
      ),
      CategoryProfileApp(
        profiles: _profiles,
        onToggleSave: _toggleSave,
        onConfirmBooking: _confirmBooking,
      ),
      SavedScreen(
        savedProfiles: _profiles.where((p) => p.isSaved).toList(),
        onToggleSave: _toggleSave,
        onConfirmBooking: _confirmBooking,
      ),
      BookedScreen(
        bookedProfiles: _profiles.where((p) => p.isBooked).toList(),
        onToggleSave: _toggleSave,
        onConfirmBooking: _confirmBooking,
      ),
      ProfileScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(255, 73, 203, 243),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color.fromARGB(223, 245, 126, 215),
        animationDuration: const Duration(milliseconds: 750),
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.category, size: 30, color: Colors.black),
          Icon(Icons.bookmark, size: 30, color: Colors.black),
          Icon(Icons.shopping_cart, size: 30, color: Colors.black),
          Icon(Icons.person, size: 30, color: Colors.black),
        ],
      ),
    );
  }
}