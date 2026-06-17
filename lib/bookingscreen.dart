import 'package:flutter/material.dart';
import 'models/data.dart';
//import 'package:widgets/profile_card.dart';
import 'package:quickfix_project/widgets/profile_card.dart';

class BookedScreen extends StatelessWidget {
  final List<Profile> bookedProfiles;
  final ValueChanged<String> onToggleSave;
  final ValueChanged<String> onConfirmBooking; // Add this

  const BookedScreen({
    super.key,
    required this.bookedProfiles,
    required this.onToggleSave,
    required this.onConfirmBooking, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade800,
        elevation: 1.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.35, 0.7, 1.0],
            colors: [
              const Color(0xFFFFDEE9).withOpacity(0.6),
              const Color(0xFFB5FFFC).withOpacity(0.6),
              const Color(0xFFCAA1FF).withOpacity(0.6),
              Colors.white.withOpacity(0.6),
            ],
          ),
        ),
        child: bookedProfiles.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your Cart is Empty',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Services you book will be added to your cart.',
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: bookedProfiles.length,
                itemBuilder: (context, index) {
                  final profile = bookedProfiles[index];
                  // CORRECTED: Pass the onConfirmBooking function
                  return ProfileCard(
                    profile: profile,
                    onToggleSave: () => onToggleSave(profile.id),
                    onConfirmBooking: () => onConfirmBooking(profile.id),
                  );
                },
              ),
      ),
    );
  }
}