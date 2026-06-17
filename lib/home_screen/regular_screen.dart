import 'package:flutter/material.dart';

class RegularCustomerDetailScreen extends StatelessWidget {
  final String name;
  final String request;
  final String image;

  const RegularCustomerDetailScreen({
    super.key,
    required this.name,
    required this.request,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      
       backgroundColor: const Color(0xFF0A385E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              request,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.message),
              label: const Text("Message",style: TextStyle(color:Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 8, 29, 61),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
