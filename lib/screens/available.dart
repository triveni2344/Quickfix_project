import 'package:flutter/material.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  bool isAvailable = true;
  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final Set<String> selectedDays = {};
  final Map<String, TimeOfDay?> startTimes = {};
  final Map<String, TimeOfDay?> endTimes = {};

  Future<void> _selectTime(String day, bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTimes[day] = picked;
        } else {
          endTimes[day] = picked;
        }
      });
    }
  }

  void _resetAll() {
    setState(() {
      isAvailable = false;
      selectedDays.clear();
      startTimes.clear();
      endTimes.clear();
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _saveAvailability() {
    if (!isAvailable) {
      _showSnackBar('You are marked as unavailable.');
      return;
    }
    if (selectedDays.isEmpty) {
      _showSnackBar('Select at least one day.');
      return;
    }

    for (var day in selectedDays) {
      final start = startTimes[day];
      final end = endTimes[day];

      if (start == null || end == null) {
        _showSnackBar('Set both start and end time for $day');
        return;
      }

      if (start.hour > end.hour || (start.hour == end.hour && start.minute >= end.minute)) {
        _showSnackBar('Start time must be before end time for $day');
        return;
      }
    }

    _showSnackBar('Availability saved successfully!');
  }

  Widget _buildDayChip(String day) {
    final isSelected = selectedDays.contains(day);
    return ChoiceChip(
      label: Text(day),
      selected: isSelected,
      onSelected: isAvailable
          ? (selected) {
              setState(() {
                if (selected) {
                  selectedDays.add(day);
                } else {
                  selectedDays.remove(day);
                }
              });
            }
          : null,
      selectedColor: const Color(0xFF006D77),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: Colors.grey[200],
      elevation: 4,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }

  Widget _buildTimeCard(String day) {
    final start = startTimes[day]?.format(context) ?? '--';
    final end = endTimes[day]?.format(context) ?? '--';
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              day,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.access_time),
                    label: Text(start),
                    onPressed: () => _selectTime(day, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[100],
                      foregroundColor:  const Color(0xFF006D77),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.access_time),
                    label: Text(end),
                    onPressed: () => _selectTime(day, false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[100],
                      foregroundColor: const Color(0xFF006D77),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Availabilities',style: TextStyle(color:Colors.white),),
        centerTitle: true,
        backgroundColor:  const Color(0xFF006D77),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile.adaptive(
                value: isAvailable,
                onChanged: (val) => setState(() => isAvailable = val),
                activeColor:  Color(0xFF006D77),
                title: const Text(
                  'Available for work?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Available Days:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: weekdays.map(_buildDayChip).toList(),
              ),
              const SizedBox(height: 20),
              if (selectedDays.isNotEmpty)
                const Text(
                  'Select Timings:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              const SizedBox(height: 10),
              ...selectedDays.map(_buildTimeCard),
              const SizedBox(height: 20),
              if (selectedDays.isNotEmpty)
                const Divider(thickness: 1.2),
              if (selectedDays.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 12),
                  child: Text(
                    'Summary:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ...selectedDays.map((day) {
                final start = startTimes[day]?.format(context) ?? '--';
                final end = endTimes[day]?.format(context) ?? '--';
                return Text('• $day: $start - $end');
              }),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                    onPressed: _saveAvailability,
                   style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF006D77),
                      side: const BorderSide(color:  Color(0xFF006D77),),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    onPressed: _resetAll,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF006D77),
                      side: const BorderSide(color:  Color(0xFF006D77),),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}