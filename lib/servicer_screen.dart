


import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:quickfix_project/home_screen.dart';
//import 'package:quickfix_project/home_screen.dart';

import 'booking_screen.dart';
import 'message_screen.dart';
import 'profile_screen.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomesScreen(),
    BookingsScreen(),
    ChatListScreen(),
    ProfileScreen(),

  ];

  final List<Color> _backgroundColors = [
   Colors.white,
   Colors.white,
   Colors.white,
   Colors.white,
     

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColors[_currentIndex],
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
    color:const Color.fromARGB(255, 70, 196, 254),
        backgroundColor: _backgroundColors[_currentIndex],
        //buttonBackgroundColor: Colors.orange,
        buttonBackgroundColor:const Color.fromARGB(255, 255, 47, 234),
        animationDuration: const Duration(milliseconds: 750),
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.home, size: 35, color: Colors.black),
          Icon(Icons.calendar_today, size: 35, color: Colors.black),
          Icon(Icons.message_rounded, size: 35, color: Colors.black),
          Icon(Icons.person, size: 35, color: Colors.black),
        ],
      ),
    );
  }
}