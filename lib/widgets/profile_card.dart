import 'package:flutter/material.dart';
// import 'package:users/models/data.dart';
// import 'package:users/widgets/profile_details.dart';
import 'package:quickfix_project/models/data.dart';
import 'package:quickfix_project/widgets/profile_details.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;
  final VoidCallback onToggleSave;
  final VoidCallback onConfirmBooking; // Added for booking logic

  const ProfileCard({
    super.key,
    required this.profile,
    required this.onToggleSave,
    required this.onConfirmBooking, // Added for booking logic
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // When the card is tapped, navigate to the details screen
        // and pass the onConfirmBooking callback to its onBooked parameter.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetailScreen(
              profile: profile,
              onBooked: onConfirmBooking, onBookingConfirmed: (bookingTime) {  }, // Use the correct function for booking
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // UI Enhancement: Replaced black circle with a styled CircleAvatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(Icons.person, color: Colors.blue.shade600),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        profile.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF334155), // Slate gray
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                // This IconButton correctly handles ONLY saving/bookmarking
                IconButton(
                  icon: Icon(
                    profile.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: profile.isSaved ? Colors.blue.shade600 : Colors.grey.shade400,
                  ),
                  onPressed: onToggleSave, // This correctly toggles the save state
                ),
              ],
            ),
            Text(
              profile.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              profile.bio,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber.shade700, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    profile.rating,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}