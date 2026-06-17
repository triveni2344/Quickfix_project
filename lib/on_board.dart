import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
   final List<Map<String, String>> onboardingData = [
  {
    'image': 'assets/on_boarding.jpg',
    'title': 'Welcome',
    'description': 'Find the best services nearby',
  },
  {
    'image': 'assets/on_board4.jpg',
    'title': 'Fast Booking',
    'description': 'Book services instantly',
  },
  {
    'image': 'assets/onboard3.jpg',
    'title': 'Trusted Providers',
    'description': 'We connect you to verified professionals',
  },
];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          onboardingData[index]['image']!,
          height: 300,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 30),
        Text(
          onboardingData[index]['title']!,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            onboardingData[index]['description']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
},

            
          ),

          // Dot indicators
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index: index),
              ),
            ),
          ),
          // Centered Next button
Positioned(
  bottom: 40,
  left: 0,
  right: 0,
  child: Center(
    child: ElevatedButton(
      onPressed: () {
        if (_currentPage < onboardingData.length - 1) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          Navigator.pushReplacementNamed(context, '/role');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF006D77),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text("Next"),
    ),
  ),
),
        ]

            ),
          );
        
      
    
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: Color(0xFF006D77),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}