
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          //fontWeight: FontWeight.bold,
          color: Colors.black,
        );
    final bodyStyle = Theme.of(context).textTheme.bodyLarge;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF006D77),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFF3F4F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Last updated: July 27, 2025',
                style: bodyStyle?.copyWith(color: Colors.grey)),
            const SizedBox(height: 24),

            _sectionHeader('1. Introduction', headerStyle),
            _sectionText(
              'This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our app.',
              bodyStyle,
            ),

            _divider(),

            _sectionHeader('2. Data Collection', headerStyle),
            _sectionText('We may collect the following types of information:', bodyStyle),
            _bullet('Personal identification information (Name, email, phone number)'),
            _bullet('Usage data and diagnostics'),
            _bullet('Device information (OS, model, IP address)'),

            _divider(),

            _sectionHeader('3. How We Use Your Data', headerStyle),
            _bullet('To improve user experience and performance'),
            _bullet('To respond to user inquiries and support requests'),
            _bullet('To comply with legal obligations'),

            _divider(),

            _sectionHeader('4. Data Sharing', headerStyle),
            _sectionText(
              'We do not sell your personal data. We may share information with trusted service providers to operate the app efficiently.',
              bodyStyle,
            ),

            _divider(),

            _sectionHeader('5. Your Rights', headerStyle),
            _bullet('Access or update your personal data'),
            _bullet('Request deletion of your data'),
            _bullet('Withdraw consent at any time'),

            _divider(),

            _sectionHeader('6. Contact Us', headerStyle),
            _sectionText(
              'If you have any questions or concerns, reach out to us at: support@example.com',
              bodyStyle,
            ),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.delete_forever),
              label: const Text('Request Data Deletion'),
              style: ElevatedButton.styleFrom(
                backgroundColor:  const Color(0xFF006D77),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Request Deletion'),
                    content: const Text(
                        'Your data deletion request has been successfully submitted.'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: style),
    );
  }

  Widget _sectionText(String text, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(text, style: style),
    );
  }

  Widget _divider() => const Divider(height: 30, thickness: 1.1, color: Colors.grey);

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 20)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}