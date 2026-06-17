import 'package:flutter/material.dart';

class CustomerDetailScreen extends StatelessWidget {
  final String name;
  final String request;
  final String image;

  const CustomerDetailScreen({
    super.key,
    required this.name,
    required this.request,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(name,style: TextStyle(color:Colors.white),),
     
     backgroundColor: const Color(0xFF006D77),
      ),
      body:
       
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              request,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              "Requested service details will be shown here...",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      
      ),
    );
  }
}
