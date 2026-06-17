
import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();

  List<Map<String, dynamic>> newRequests = [
    {
      'name': 'Michael Brown',
      'service': 'Fan Repair',
      'icon': Icons.plumbing,
      'distance': '2.1 m',
      'time': '9:30 AM',
      'status': 'pending'
    },
    {
      'name': 'Emma Davis',
      'service': 'Electrical',
      'icon': Icons.electrical_services,
      'distance': '1.5 m',
      'time': '10:00 AM',
      'status': 'pending'
    },
    {
      'name': 'David Wilson',
      'service': 'AC Repair',
      'icon': Icons.ac_unit,
      'distance': '3.8 m',
      'time': '11:00 AM',
      'status': 'pending'
    },
    {
      'name': 'Liam Martinez',
      'service': 'Washing Machine Repair',
      'icon': Icons.local_laundry_service,
      'distance': '2.4 m',
      'time': '1:15 PM',
      'status': 'pending'
    },
    {
      'name': 'Olivia Garcia',
      'service': 'Tv Repair',
      'icon': Icons.cleaning_services,
      'distance': '1.1 m',
      'time': '2:45 PM',
      'status': 'pending'
    },
    {
      'name': 'Noah Anderson',
      'service': 'Laptop Repair',
      'icon': Icons.laptop_mac,
      'distance': '4.5 m',
      'time': '4:00 PM',
      'status': 'pending'
    },
    {
      'name': 'James Lee',
      'service': 'Water Purifier Service',
      'icon': Icons.water_damage,
      'distance': '3.2 m',
      'time': '6:00 PM',
      'status': 'pending'
    },
    {
      'name': 'Alice',
      'service': 'Refrigerator Repair',
      'icon': Icons.kitchen,
      'distance': '2.6 m',
      'time': '7:30 PM',
      'status': 'pending'
    },
    {
      'name': 'Elijah White',
      'service': 'Inverter Repair',
      'icon': Icons.chair_alt,
      'distance': '1.2 m',
      'time': '8:00 PM',
      'status': 'pending'
    },
  ];

  List<Map<String, dynamic>> accepted = [];
  List<Map<String, dynamic>> completed = [];

  List<Map<String, dynamic>> todaysSchedule = [
    {'name': 'Saria Johnson', 'avatar': 'assets/men1.jpg', 'time': '8:00 AM'},
    {'name': 'Daniel Carter', 'avatar': 'assets/men2.jpg', 'time': '10:00 AM'},
    {'name': 'Grace Turner', 'avatar': 'assets/men3.jpg', 'time': '11:30 AM'},
    {'name': 'Jacob Adams', 'avatar': 'assets/men4.jpg', 'time': '1:00 PM'},
    {'name': 'Grace leona', 'avatar': 'assets/girl1.jpg', 'time': '3:30 PM'},
    {'name': 'Henry Lopez', 'avatar': 'assets/girl2.jpg', 'time': '5:15 PM'},
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  
   void updateStatus(int index, String action) {
  final request = newRequests[index];

  setState(() {
    newRequests.removeAt(index);
    request['status'] = action;
    if (action == 'accepted') {
      accepted.add(request);
    } else if (action == 'rejected') {
      // Do nothing
    }
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 4),
      content: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: action == 'accepted'
                ? [const Color.fromARGB(255, 132, 232, 184), const Color.fromARGB(255, 144, 238, 149)]
                : [const Color.fromARGB(255, 221, 117, 117), const Color.fromARGB(255, 224, 104, 104)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              action == 'accepted' ? Icons.check : Icons.close,
              color: Colors.black,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                action == 'accepted'
                    ? 'Request accepted successfully'
                    : 'Request rejected',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (action == 'accepted') {
                    accepted.remove(request);
                  }
                  newRequests.insert(index, request);
                });
              },
              child: Text(
                "UNDO",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget buildRequestCard(Map<String, dynamic> data, int index) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black45, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text(data['name'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            Spacer(),
            Text(data['distance'], style: TextStyle(color:Color(0xFF222222))),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(data['icon'], color: Colors.orange, size: 18),
            SizedBox(width: 6),
            Text(data['service'], style: TextStyle(color: const Color.fromARGB(255, 32, 31, 31),fontSize: 14)),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Text(data['time'],
                style: TextStyle(color: Colors.white, fontSize: 16)),
            Spacer(),
            ElevatedButton(
              onPressed: () => updateStatus(index, 'accepted'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 110, 224, 114),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child:
                  Text('Accept', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => updateStatus(index, 'rejected'),
              style: ElevatedButton.styleFrom(
               // backgroundColor: const Color.fromARGB(255, 213, 28, 15),
               backgroundColor: Color.fromARGB(255, 250, 132, 132),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child:
                  Text('Reject', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            ),
          ],
        )
      ]),
    );
  }

  Widget buildAcceptedCard(Map<String, dynamic> data, int index) {
    return Container(
      
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black45, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(data['icon'], color: Colors.orange),
            title: Text(data['name'],
                style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold)),
            subtitle:
                Text(data['service'], style: TextStyle(color: Colors.black,fontSize: 14)),
            trailing: Text(data['time'],
                style: TextStyle(color:Color(0xFF222222), )),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              
              onPressed: () {
  setState(() {
    accepted.removeAt(index);
    completed.add(data);
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 4),
      content: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 84, 200, 204), const Color.fromARGB(255, 70, 170, 160)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.black),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Marked as completed",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
                 TextButton(
                   onPressed: () {
                     setState(() {
                      completed.remove(data);
                       accepted.insert(index, data);
                      });
                     },
                 child: Text(
                 "UNDO",
                  style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                      ),
                      ),
                   ),
                 ],
               ),
             ),
            ),
           );
           },

             style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 95, 203, 99),
                foregroundColor: Colors.black,
              ),
              child: Text("Mark as Completed",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCompletedCard(Map<String, dynamic> data) {
    return Container(
     padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black45, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.check_circle, color: Colors.green,size: 28,),
        title: Text(data['name'],
            style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold)),
        subtitle:
            Text(data['service'], style: TextStyle(color: Colors.black,fontSize:14 )),
        trailing: Text(data['time'],
            style: TextStyle(color: Colors.blue, )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(

    backgroundColor: const Color(0xFF006D77),
    


        elevation: 0,
        title: Text('Bookings', style: TextStyle(fontSize: 24,color: Colors.white),),
        
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(text: 'New Requests'),
            Tab(text: 'Accepted'),
            Tab(text: 'Completed'),
          ],
          onTap: (index) => _pageController.jumpToPage(index),
        ),
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
     child:  PageView(
        controller: _pageController,
        onPageChanged: (index) => _tabController.animateTo(index),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ...newRequests
                    .asMap()
                    .entries
                    .map((e) => buildRequestCard(e.value, e.key)),
                SizedBox(height: 20),
                Text("Today's Schedule",
                    style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                ...todaysSchedule.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScheduleDetailPage(
                            name: entry['name'],
                            avatar: entry['avatar'],
                            time: entry['time'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                       margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                        color: Colors.white,
                         borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                           BoxShadow(color: Colors.black45, blurRadius: 6, offset: Offset(0, 2)),
                       ],
                     ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(entry['avatar']),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry['name'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold)),
                                Text("Scheduled at ${entry['time']}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.white70)
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: accepted.length,
            itemBuilder: (_, index) => buildAcceptedCard(accepted[index], index),
          ),
          completed.isEmpty
              ? Center(
                  child: Text(
                    "No completed tasks yet.",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: completed.length,
                  itemBuilder: (_, index) =>
                      buildCompletedCard(completed[index]),
                ),
        ],
      ),
      )
    );
  }
}

class ScheduleDetailPage extends StatelessWidget {
  final String name;
  final String avatar;
  final String time;

  const ScheduleDetailPage({
    super.key,
    required this.name,
    required this.avatar,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar( 
      backgroundColor: const Color(0xFF006D77),
        elevation: 0,
        title: Text('Booking Details',style: TextStyle(color:Colors.white),),
      ),
      body:
       Container(
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
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(avatar),
                radius: 50,
              ),
            ),
            SizedBox(height: 24),
            Text(name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Scheduled for $time",
                style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
      ),
       )
    );
  }
}


