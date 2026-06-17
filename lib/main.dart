import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'splash_screen.dart';
//import 'welcome_screen.dart';


void main() {
  runApp(DevicePreview(builder: (context) => QuickFixApp(),));
}


class QuickFixApp extends StatelessWidget {
  const QuickFixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickFix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       // primaryColor: Color(0xFF1E88E5),
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF212121)),
        ),
      ),
      //home: const WelcomeScreen(),
      home: const SplashScreen(),
    );
  }
}
