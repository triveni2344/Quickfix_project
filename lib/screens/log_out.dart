import 'package:flutter/material.dart';
import 'package:quickfix_project/login_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String quote = "Take a break. You've earned it. Come back stronger!";

    return Scaffold(
      backgroundColor: Color(0xFFF2F3F7),
      appBar: AppBar(
        title: const Text('Logged Out',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF006D77),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.logout, size: 60, color:  Color(0xFF006D77)),
                  const SizedBox(height: 16),
                  const Text(
                    "You've been logged out",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    quote,
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                    
                     Navigator.pushNamed(
                       context,
                         '/login',
                    );
                    },
                    icon: const Icon(Icons.login,color: Color(0xFF006D77)),
                    label: const Text('Go to Login',style: TextStyle(color:Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006D77),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}