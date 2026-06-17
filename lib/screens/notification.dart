import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool newJobs = true;
  bool payments = true;
  bool messages = true;
  bool promos = false;
  bool emailUpdates = false;
  bool systemAlerts = true;

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Settings saved successfully"),
        backgroundColor:  Color(0xFF006D77),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: SwitchListTile(
        secondary: Icon(icon, color:  Color(0xFF006D77),),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        value: value,
        onChanged: onChanged,
        activeColor: Color(0xFF006D77),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.grey[200],
        width: double.infinity,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Settings",style: TextStyle(color:Colors.white),),
       backgroundColor: const Color(0xFF006D77),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100), // To avoid FAB overlap
            children: [
              _buildSection("Job Alerts"),
              _buildSwitchTile(
                icon: Icons.work_outline,
                title: "New Job Opportunities",
                value: newJobs,
                onChanged: (val) => setState(() => newJobs = val),
              ),
              _buildSwitchTile(
                icon: Icons.payment,
                title: "Payment Received",
                value: payments,
                onChanged: (val) => setState(() => payments = val),
              ),

              _buildSection("Communication"),
              _buildSwitchTile(
                icon: Icons.message_outlined,
                title: "Messages from Clients",
                value: messages,
                onChanged: (val) => setState(() => messages = val),
              ),
              _buildSwitchTile(
                icon: Icons.email_outlined,
                title: "Email Updates",
                value: emailUpdates,
                onChanged: (val) => setState(() => emailUpdates = val),
              ),

              _buildSection("Other Notifications"),
              _buildSwitchTile(
                icon: Icons.local_offer_outlined,
                title: "Promotional Offers",
                value: promos,
                onChanged: (val) => setState(() => promos = val),
              ),
              _buildSwitchTile(
                icon: Icons.warning_amber_outlined,
                title: "System Alerts",
                value: systemAlerts,
                onChanged: (val) => setState(() => systemAlerts = val),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, right: 12.0),
        child: FloatingActionButton.extended(
          onPressed: _saveSettings,
          icon: const Icon(Icons.save),
          label: const Text("Save"),
          backgroundColor:  const Color(0xFF006D77),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}