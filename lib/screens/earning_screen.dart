import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EarningsDashboardScreen extends StatelessWidget {
  EarningsDashboardScreen({super.key});

  final List<Map<String, dynamic>> paymentHistory = [
    {
      'client': 'Alice Martin',
      'service': 'AC Repair',
      'amount': 120.0,
      'status': 'Paid',
      'date': DateTime(2025, 7, 25),
    },
    {
      'client': 'Bob Smith',
      'service': 'Lawn Mowing',
      'amount': 80.0,
      'status': 'Pending',
      'date': DateTime(2025, 7, 26),
    },
    {
      'client': 'Clara White',
      'service': 'House Cleaning',
      'amount': 200.0,
      'status': 'Paid',
      'date': DateTime(2025, 7, 20),
    },
  ];

  double getTotalEarnings() {
    return paymentHistory
        .where((e) => e['status'] == 'Paid')
        .fold(0.0, (sum, item) => sum + item['amount']);
  }

  double getPendingAmount() {
    return paymentHistory
        .where((e) => e['status'] == 'Pending')
        .fold(0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    final total = getTotalEarnings();
    final pending = getPendingAmount();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings Dashboard'),
       backgroundColor: const Color(0xFF006D77),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEarningsCard('Total Earnings', total, Colors.green),
            const SizedBox(height: 10),
            _buildEarningsCard('Pending Payments', pending, Colors.orange),
            const SizedBox(height: 20),

            const Text('Earnings Summary (Graph)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildBarChart(total, pending),
            const SizedBox(height: 20),

            const Text('Payment History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...paymentHistory.map(_buildHistoryItem),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsCard(String title, double amount, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: Icon(Icons.monetization_on, color: color, size: 36),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }

  Widget _buildBarChart(double paid, double pending) {
    final double maxVal = (paid > pending ? paid : pending) * 1.2;

    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBar(label: 'Paid', value: paid, color: Colors.green, max: maxVal),
          const SizedBox(width: 20),
          _buildBar(label: 'Pending', value: pending, color: Colors.orange, max: maxVal),
        ],
      ),
    );
  }

  Widget _buildBar({
    required String label,
    required double value,
    required double max,
    required Color color,
  }) {
    final double heightFactor = max > 0 ? value / max : 0;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('\$${value.toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            height: 120 * heightFactor,
            width: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> payment) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              payment['status'] == 'Paid' ? Colors.green : Colors.orange,
          child: Icon(
            payment['status'] == 'Paid' ? Icons.check : Icons.hourglass_top,
            color: Colors.white,
          ),
        ),
        title: Text(payment['service']),
        subtitle: Text('Client: ${payment['client']}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${payment['amount'].toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat.MMMd().format(payment['date']),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}