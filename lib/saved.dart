import 'package:flutter/material.dart';
// import 'package:users/models/data.dart';
// import 'package:users/widgets/profile_card.dart';
import 'package:quickfix_project/models/data.dart';
import 'package:quickfix_project/widgets/profile_card.dart';

// This is your 'saved.dart' file content
class SavedScreen extends StatelessWidget {
  final List<Profile> savedProfiles;
  final ValueChanged<String> onToggleSave;
  final ValueChanged<String> onConfirmBooking; // Add this

  const SavedScreen({
    super.key,
    required this.savedProfiles,
    required this.onToggleSave,
    required this.onConfirmBooking, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Profiles'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
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
        child: savedProfiles.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No Saved Profiles',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap the bookmark icon on a profile to save it here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: savedProfiles.length,
                itemBuilder: (context, index) {
                  final profile = savedProfiles[index];
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