
import 'package:flutter/material.dart';

class MyPrivacyPolicy extends StatelessWidget {
  const MyPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final fontSize = width * 0.042; // Adjusts font size based on screen width
    final horizontalPadding = width * 0.05;
    final verticalPadding = height * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Privacy Policy",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Text(
              _privacyText,
              style: TextStyle(
                fontSize: fontSize,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const String _privacyText = '''
Privacy Policy for Quick Fix

Privacy Policy
Last updated: July 29, 2025

This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.

We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.

Interpretation and Definitions
Interpretation
The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.

Definitions
For the purposes of this Privacy Policy:

Account means a unique account created for You to access our Service or parts of our Service.

Affiliate means an entity that controls, is controlled by or is under common control with a party...

Application refers to Quick Fix...

[... OMITTED FOR BREVITY ...]

Contact Us
If you have any questions about this Privacy Policy, You can contact us:

By phone number: 9533964433

Generated using TermsFeed Privacy Policy Generator
''';
