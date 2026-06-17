


import 'package:flutter/material.dart';

class BScreen extends StatelessWidget {
  const BScreen({super.key});

  final List<Map<String, dynamic>> bookings = const [
    {
      'service': 'AC Repair',
      'customer': 'John',
      'date': 'Mon, Jul 29',
      'time': '10:00 AM',
      'problem': 'AC not cooling properly',
      'image' : 'assets/ac_repair2.jpg'
    },
    {
      'service': 'Electrical Fix',
      'customer': 'David',
      'date': 'Wed, Jul 31',
      'time': '02:00 PM',
      'problem': 'Short circuit in kitchen',
       'image':'assets/electrical_issue.jpg'
    },
    
     {
      'service': 'Inverter Repair',
      'customer': 'Rahim',
      'date': 'Fri, Aug 01',
      'time': '03:00 PM',
      'problem': 'Problem in inverter battery',
       'image':'assets/inverter_repair.jpg'
    },
    {
      'service': 'Plumbing',
      'customer': 'Alice',
      'date': 'Tue, Jul 30',
      'time': '12:30 PM',
      'problem': 'Leak in bathroom pipe',
       'image':'assets/plumber3.jpg'
    },
    {
  'service': 'Switchboard Fix',
  'customer': 'Arjun',
  'date': 'Tue, Aug 07',
  'time': '01:30 PM',
  'problem': 'Switches sparking in bedroom panel',
  'image': 'assets/switchboard.jpg',
    },
      {
  'service': 'Geyser Plumbing',
  'customer': 'Harsha',
  'date': 'Fri, Aug 10',
  'time': '09:45 AM',
  'problem': 'Hot water pipe disconnected from geyser',
  'image': 'assets/geysur_repair.jpg',
},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF5F7FA),
      backgroundColor: Color(0xFFF0F1F5),
      appBar: AppBar(
     // backgroundColor: const Color(0xFF0A385E),

      backgroundColor: Color(0xFF006D77),
        title: const Text(
          'Hey, Service Provider 👋',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://tse3.mm.bing.net/th/id/OIP.ch-YhuPxVQvrln7iv5BDQwHaHa?pid=Api&P=0&h=220',
              ),
            ),
          )
        ],
      ),
      body: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 0.35, 0.7, 1.0],
      colors: [
        const Color(0xFFFFDEE9), // light pink
        const Color(0xFFB5FFFC), // light blue
        const Color(0xFFCAA1FF), // light purple
        Colors.white.withOpacity(0.5), // soft white
      ],
    ),
  ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowDetailsScreen(booking: booking),
                  ),
                );
              },
            
              child: Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  elevation: 5,
  margin: const EdgeInsets.symmetric(vertical: 10),
  //color: Colors.white,
  color: Colors.white,
  child: Column(
    children: [
      ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Image.asset(
          booking['image'],
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.build_circle_outlined, color: Color(0xFF0A385E)),
                const SizedBox(width: 8),
                Text(
                  booking['service'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A385E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("👤 Customer: ${booking['customer']}"),
            Text("📅 Date: ${booking['date']}"),
            Text("⏰ Time: ${booking['time']}"),
            const SizedBox(height: 8),
            Text(
              "Tap to view details",
              style: TextStyle(
                color: Colors.deepOrange,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),



            );
          },
        ),
      ),
      ),
    );
  }
}



class ShowDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> booking;

  const ShowDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF006D77),
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
        child: Center(
          child: Card(
            elevation: 6,
            //color: const Color(0xFFE3F2FD), 
            color:Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 320,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(Icons.assignment_turned_in_rounded, size: 40, color: Color(0xFF0A385E)),
                  ),
                  const SizedBox(height: 16),
                  detailRow("🛠️ Service", booking['service']),
                  detailRow("👤 Customer", booking['customer']),
                  detailRow("📅 Date", booking['date']),
                  detailRow("⏰ Time", booking['time']),
                  detailRow("📝 Problem", booking['problem']),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        "$title: $value",
        style: const TextStyle(fontSize: 16, color: Color(0xFF263238)),
      ),
    );
  }
}
