

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'earning_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool paymentReceived = false;

  final String transactionId = 'TXN758412356';
  final String service = 'Deep Cleaning';
  final String clientName = 'Sarah Johnson';
  final String paymentMode = 'UPI';
  final double serviceAmount = 150.00;

  void _togglePaymentStatus(bool? value) {
    setState(() {
      paymentReceived = value ?? false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(paymentReceived
            ? '✅ Payment marked as received.'
            : '⚠ Payment marked as pending.'),
        backgroundColor: paymentReceived ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _requestWithdrawal() {
    if (!paymentReceived) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please mark payment as received first.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Withdrawal Requested'),
        content: const Text(
          'Your payout request has been submitted and will be processed shortly.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMd().format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInfoCard(date),
            const SizedBox(height: 20),
            _buildStatusSwitch(),
            const SizedBox(height: 25),
            // _buildWithdrawButton(),
            const SizedBox(height: 12),
            _buildDashboardButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String date) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service Payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey[900])),
            const SizedBox(height: 10),
            _infoRow(Icons.calendar_today_outlined, 'Date', date),
            _infoRow(Icons.cleaning_services_outlined, 'Service', service),
            _infoRow(Icons.person_outline, 'Client', clientName),
            _infoRow(Icons.numbers_outlined, 'Transaction ID', transactionId),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _tag('Mode: $paymentMode', Icons.payment, Colors.indigo),
                _tag(
                  paymentReceived ? 'Status: Received' : 'Status: Pending',
                  paymentReceived ? Icons.check_circle : Icons.timelapse,
                  paymentReceived ? Colors.green : Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Amount',
                    style: TextStyle(fontSize: 15, color: Colors.black54)),
                Text(
                  '\$${serviceAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54))),
          Text(value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _tag(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSwitch() {
    return SwitchListTile(
      value: paymentReceived,
      onChanged: _togglePaymentStatus,
      title: Text(
        paymentReceived ? 'Payment Received' : 'Mark as Payment Received',
        style: TextStyle(
          color: paymentReceived ? Colors.green[800] : Colors.orange[800],
          fontWeight: FontWeight.w600,
        ),
      ),
      secondary: Icon(
        paymentReceived ? Icons.check_circle_outline : Icons.pending_actions,
        color: paymentReceived ? Colors.green : Colors.orange,
      ),
      activeColor: Colors.green,
    );
  }

 

  Widget _buildDashboardButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => EarningsDashboardScreen()));
        },
        icon: const Icon(Icons.bar_chart),
        label: const Text('View Earnings Dashboard'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          side: const BorderSide(color: Colors.blueAccent),
          foregroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}