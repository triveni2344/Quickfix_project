import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'welcome_screen.dart';

//  import 'package:users/bookingscreen.dart'; // Assuming these are your file imports
//  import 'package:users/categories.dart';
// import 'package:users/homescreen.dart';
// import 'package:users/models/data.dart';
// import 'package:users/profile.dart';
// import 'package:users/saved.dart';

import 'package:quickfix_project/bookingscreen.dart';
import 'package:quickfix_project/models/data.dart';
import 'package:quickfix_project/profile.dart';
import 'package:quickfix_project/saved.dart';
import 'package:quickfix_project/categories.dart';
import 'package:quickfix_project/homescreen.dart';



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
//       // Set SplashScreen as the initial route
//       home: const SplashScreen(),
//     );
//   }
// }

// --- SplashScreen widget added from the first code block ---
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final String _text = 'QuickFix';
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(_text.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      );
    });

    // _slideAnimations = _controllers.map((controller) {
    //   return Tween<Offset>(
    //     begin: const Offset(0, -1), // Start above screen
    //     end: Offset.zero, // End at original position
    //   ).animate(
    //     CurvedAnimation(parent: controller, curve: Curves.easeOut),
    //   );
    // }).toList();
     _slideAnimations = List.generate(_text.length, (index) {
      final beginOffset = (index % 2 == 0)
          ? const Offset(0, -1)
          : const Offset(0, 1);
      return Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
        CurvedAnimation(parent: _controllers[index], curve: Curves.easeOut),
      );
    });


  //   _fadeAnimations = _controllers.map((controller) {
  //     return Tween<double>(begin: 0, end: 1).animate(
  //       CurvedAnimation(parent: controller, curve: Curves.easeIn),
  //     );
  //   }).toList();

  //   _playAnimationsSequentially();

  // }
      _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    }).toList();

    _playAnimationsSequentially();
  }



  Future<void> _playAnimationsSequentially() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (!mounted) return;
      await _controllers[i].forward();
    }
    // Wait after all letters animated
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.black,
      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFFDEE9).withOpacity(0.8),
              const Color(0xFFB5FFFC).withOpacity(0.8),
              const Color.fromARGB(255, 115, 223, 225).withOpacity(0.8),
              Colors.white.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),


      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/splash.jpg', height: 180),
              const SizedBox(height: 40),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_text.length, (index) {
                  return SlideTransition(
                    position: _slideAnimations[index],
                    child: FadeTransition(
                      opacity: _fadeAnimations[index],
                      child: Text(
                        _text[index],
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 0,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black45,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
      ),
      )
    );
  }
}


// --- HomePage using the more complete version from the second code block ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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


