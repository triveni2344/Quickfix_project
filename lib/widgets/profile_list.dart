import 'package:flutter/material.dart';
// import 'package:users/models/data.dart';
// import 'package:users/widgets/profile_card.dart';
import 'package:quickfix_project/models/data.dart';
import 'package:quickfix_project/widgets/profile_card.dart';

class ProfileList extends StatelessWidget {
  final List<Profile> profiles;
  final String activeCategory;
  final ValueChanged<String> onToggleSave;
  final ValueChanged<String> onConfirmBooking;

  const ProfileList({
    super.key,
    required this.profiles,
    required this.activeCategory,
    required this.onToggleSave,
    required this.onConfirmBooking,
  });
  
  @override
  Widget build(BuildContext context) {
    final filteredProfiles = activeCategory == 'all'
        ? profiles
        : profiles.where((profile) => profile.category == activeCategory).toList();

    return Container(
      // Padding is adjusted for the new layout.
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for the currently selected category.
          Text(
            categoriesData.firstWhere((cat) => cat.id == activeCategory).name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filteredProfiles.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: filteredProfiles.length,
                    itemBuilder: (context, index) {
                      final profile = filteredProfiles[index];
                      return ProfileCard(
                        profile: profile,
                        onToggleSave: () => onToggleSave(profile.id),
                        onConfirmBooking: () => onConfirmBooking(profile.id),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No professionals found.',
                      style: TextStyle(color: Color(0xFF718096)),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}