


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'home_screen/booking.dart';
import 'home_screen/service.dart';
import 'home_screen/earning.dart';
import 'home_screen/review.dart';
import 'regular_customer.dart';

class HomesScreen extends StatelessWidget {
  const HomesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> bannerImages = [
      'assets/electrician1.jpg',
      'assets/electrician3.jpg',
      'assets/electrician2.jpg',
    ];

    final List<Map<String, String>> regularCustomers = [
      {'name': 'Virat', 'time': 'Requested AC Service', 'image': 'assets/men1.jpg'},
      {'name': 'Sasi Kumar', 'time': 'Requested Plumbing Repair', 'image': 'assets/men2.jpg'},
      {'name': 'Teja', 'time': 'Requested Fridge Repair', 'image': 'assets/men3.jpg'},
      {'name': 'Ajay Kumar', 'time': 'Requested AC Gas Refill', 'image': 'assets/men4.jpg'},
      {'name': 'Ramesh Varma', 'time': 'Requested Tv repair', 'image': 'assets/men6.jpg'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.35, 0.7, 1.0],
        colors: [
          Color(0xFFFFDEE9), // light pink
          Color(0xFFB5FFFC), // light blue
          Color(0xFFCAA1FF), // light purple
          Colors.white.withOpacity(0.5), // touch of white
        ],
      ),
    ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Welcome, Alice 👋",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Here’s what’s happening today.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6E6E6E),
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/boy_avatar.jpg'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            CarouselSlider(
              options: CarouselOptions(
                height: 160,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: bannerImages.map((imagePath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),

            const SizedBox(height: 10),

            GridView.count(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.15,
              children: [
                _buildCard(
                  title: "Today Booking",
                  icon: Icons.calendar_today,
                  context: context,
                  screen: const BScreen(),
                 color:Color.fromARGB(255, 40, 172, 174), 
                  //color:Color.fromARGB(255, 65, 135, 186),
                ),
                _buildCard(
                  title: "Services",
                  icon: Icons.build_circle,
                  context: context,
                  screen: const ServiceScreen(),
                 color:Color.fromARGB(255, 40, 172, 174), 
                ),
                _buildCard(
                  title: "Earnings",
                  icon: Icons.attach_money,
                  context: context,
                  screen: EarningsDashboardScreen(),
                 color:Color.fromARGB(255, 40, 172, 174), 
                ),
                _buildCard(
                  title: "Reviews",
                  icon: Icons.reviews,
                  context: context,
                  screen: const ReviewsScreen(),
                   color:Color.fromARGB(255, 40, 172, 174),   // Light green
                ),

                
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Regular Customers',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),

            const SizedBox(height: 15),

            ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: regularCustomers.length,
              itemBuilder: (context, index) {
                final service = regularCustomers[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomerDetailScreen(
                          name: service['name']!,
                          request: service['time']!,
                          image: service['image']!,
                        ),
                      ),
                    );
                  },
                  

                  child: Container(
  margin: const EdgeInsets.only(bottom: 12),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFF0F4FF), // Light Blue Tint
        Color(0xFFE6EEFF), // Very Pale Blue
      ],
    ),
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    children: [
      CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(service['image']!),
      ),
      const SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service['name']!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            service['time']!,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6E6E6E),
            ),
          ),
        ],
      ),
    ],
  ),
),

                );
              },
            ),
          ],
        ),
      ),
      )
    );
    
  }


  Widget _buildCard({
  required String title,
  required IconData icon,
  required BuildContext context,
  required Widget screen,
  required Color color,
}) {
  return InkWell(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: color, // Solid background color
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              size: 30,
              color: color.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Better contrast on dark card
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
}