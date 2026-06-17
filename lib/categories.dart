import 'package:flutter/material.dart';
// import 'package:users/models/data.dart';
// import 'package:users/widgets/category_list.dart';
// import 'package:users/widgets/profile_list.dart';
import 'package:quickfix_project/models/data.dart';
import 'package:quickfix_project/widgets/category_list.dart';
import 'package:quickfix_project/widgets/profile_list.dart';

class CategoryProfileApp extends StatefulWidget {
  final List<Profile> profiles;
  final ValueChanged<String> onToggleSave;
  final ValueChanged<String> onConfirmBooking;
  final String initialCategory;

  const CategoryProfileApp({
    super.key,
    required this.profiles,
    required this.onToggleSave,
    required this.onConfirmBooking,
    this.initialCategory = 'all',
  });

  @override
  State<CategoryProfileApp> createState() => _CategoryProfileAppState();
}

class _CategoryProfileAppState extends State<CategoryProfileApp> {
  late String _activeCategory;

  @override
  void initState() {
    super.initState();
    _activeCategory = widget.initialCategory;
  }

  void _selectCategory(String categoryId) {
    setState(() {
      _activeCategory = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade800,
        elevation: 0.5,
        title: Text(
          'Find a Professional',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.35, 0.7, 1.0],
                colors: [
                  const Color(0xFFFFDEE9).withOpacity(0.8),
                  const Color(0xFFB5FFFC).withOpacity(0.8),
                  const Color(0xFFCAA1FF).withOpacity(0.8),
                  Colors.white.withOpacity(0.8),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CORRECTED: onConfirmBooking is removed from here
              CategoryList(
                categories: categoriesData,
                activeCategory: _activeCategory,
                onSelectCategory: _selectCategory,
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  // onConfirmBooking correctly passed to ProfileList
                  child: ProfileList(
                    key: ValueKey<String>(_activeCategory),
                    profiles: widget.profiles,
                    activeCategory: _activeCategory,
                    onToggleSave: widget.onToggleSave,
                    onConfirmBooking: widget.onConfirmBooking,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}