import 'package:flutter/material.dart';
//import 'package:users/models/data.dart';
import 'package:quickfix_project/models/data.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final String activeCategory;
  final ValueChanged<String> onSelectCategory;

  // CORRECTED: onConfirmBooking has been removed from this constructor
  const CategoryList({
    super.key,
    required this.categories,
    required this.activeCategory,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    // The rest of this file remains the same.
    return Container(
      width: 100,
      color: const Color.fromARGB(29, 0, 0, 0),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = activeCategory == category.id;

          return GestureDetector(
            onTap: () => onSelectCategory(category.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: isSelected ? const Color.fromARGB(255, 255, 255, 255) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      category.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.blue.shade800 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}