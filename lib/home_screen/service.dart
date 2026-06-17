

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ServiceScreen(),
    );
  }
}

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'title': 'AC Installation',
        'subtitle': 'Professional AC installation at your location',
        'image': 'assets/ac_repair.jpg',
        'tasks': [
          'Window & split AC setup',
          'Wall drilling and frame mounting',
          'Copper pipe fitting',
          'Wiring and insulation',
          'Power connection setup',
        ],
      },
      {
        'title': 'Plumbing Services',
        'subtitle': 'Leak fixes, pipe fittings, and tap installations',
        'image': 'assets/plumber.jpg',
        'tasks': [
          'Tap & shower installation',
          'Leaky pipe repair',
          'Clogged drain cleaning',
          'Bathroom fittings',
          'Geyser water connection',
        ],
      },
      {
        'title': 'Electrical Repairs',
        'subtitle': 'Fan, switchboard, wiring, and fuse repairs',
        'image': 'assets/electrical_repair.jpg',
        'tasks': [
          'Switchboard fixing',
          'Ceiling fan repair',
          'Wiring & rewiring',
          'MCB/fuse replacement',
          'Socket installation',
        ],
      },
      {
  'title': 'Inverter Installation',
  'subtitle': 'Install and configure home inverters',
  'image': 'assets/inverter_repair.jpg',
  'tasks': [
    'Wall-mounted or floor setup',
    'Battery connection & charging test',
    'Wiring to main switchboard',
    'Load calculation & distribution',
    'Inverter app pairing (if supported)',
  ],
},
{
  'title': 'Water Motor Repair',
  'subtitle': 'Repair water pump and motor faults',
  'image': 'assets/mortar_repair.jpg',
  'tasks': [
    'Motor rewinding',
    'Water pump leakage fix',
    'Wiring & power connection',
    'Valve cleaning & replacement',
    'Float switch repair',
  ],
},
{
  'title': 'Kitchen Plumbing',
  'subtitle': 'Sink, drain & water purifier installations',
  'image': 'assets/kitchen_plumbing.jpg',
  'tasks': [
    'Sink & tap fitting',
    'Water purifier connection',
    'Drain pipe alignment',
    'Leak-proof joint sealing',
    'RO inlet/outlet setup',
  ],
},
{
  'title': 'Emergency Electrical Fix',
  'subtitle': 'Urgent solutions for sudden power issues',
  'image': 'assets/electrician1.jpg',
  'tasks': [
    'Power outage diagnosis',
    'MCB tripping fix',
    'Burnt wiring replacement',
    'Main switch issue handling',
    'Quick restoration support',
  ],
},

    ];

    return Scaffold(

      appBar: AppBar(
      
      backgroundColor: Color(0xFF006D77),
      //  backgroundColor: Color(0xFF3C7198),
        elevation: 0,
        title: const Text(
          'Available Services',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
  
  

        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServiceDetailScreen(
                      title: service['title'] as String,
                      description: service['subtitle'] as String,
                      image: service['image'] as String,
                      tasks: service['tasks'] as List<String>,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.asset(
                        service['image'] as String,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service['title'] as String,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              service['subtitle'] as String,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.orange),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ServiceDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final List<String> tasks;

  const ServiceDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    backgroundColor: Colors.black,
      appBar: AppBar(
        //backgroundColor: const Color(0xFF0A385E),
        backgroundColor: Color(0xFF006D77),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.35, 0.7, 1.0],
            colors: [
              const Color(0xFFFFDEE9), // light pink
              const Color(0xFFB5FFFC), // light blue
              const Color(0xFFCAA1FF), // light purple
              Colors.white.withOpacity(0.5), // touch of white
            ],
          ),
        ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                height: 140,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Included Services:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...tasks.map((task) => ListTile(
                  leading: const Icon(Icons.check, color: Color.fromARGB(255, 7, 118, 230)),
                  title: Text(
                    task,
                    style: const TextStyle(color: Colors.black),
                  ),
                )),
            const SizedBox(height: 30),
          
          ],
        ),
      ),
      ),
    );
  }
}
