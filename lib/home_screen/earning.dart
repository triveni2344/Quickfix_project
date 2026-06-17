

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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF9F9FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEarningsCard('Total Earnings', total, Colors.green),
            const SizedBox(height: 12),
            _buildEarningsCard('Pending Payments', pending, Colors.orange),
            const SizedBox(height: 24),

            const Text('Earnings Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _buildBarChart(total, pending),
            const SizedBox(height: 24),

            const Text('Payment History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            ...paymentHistory.map(_buildHistoryItem),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsCard(String title, double amount, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(Icons.monetization_on, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54)),
                const SizedBox(height: 4),
                Text('\$${amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(double paid, double pending) {
    final double maxVal = (paid > pending ? paid : pending) * 1.2;

    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBar(label: 'Paid', value: paid, color: Colors.green, max: maxVal),
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('\$${value.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          height: 100 * heightFactor,
          width: 26,
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> payment) {
    final statusColor =
        payment['status'] == 'Paid' ? Colors.green : Colors.orange;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(
            payment['status'] == 'Paid' ? Icons.check : Icons.hourglass_top,
            color: statusColor,
          ),
        ),
        title: Text(payment['service'],
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('Client: ${payment['client']}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$${payment['amount'].toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(DateFormat.MMMd().format(payment['date']),
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}