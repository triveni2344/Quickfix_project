

import 'package:flutter/material.dart';
import 'on_board.dart';
import 'role.dart';
import 'login_screen.dart';
import 'signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickFix App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
          case '/role':
            return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
          case '/login':
            final role = settings.arguments as String? ?? 'Customer';
            return MaterialPageRoute(
              builder: (_) => LoginScreen(selectedRole: role),
            );
          case '/signup':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          default:
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
        }
      },
    );
  }
}
