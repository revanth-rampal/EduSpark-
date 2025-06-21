import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'camera_scan_screen.dart'; // For navigation to the camera view

// An enum to clearly define the attendance status.
enum AttendanceStatus { pending, present, absent }

// A simple data model for a student.
class Student {
  final String id;
  final String name;
  final String avatarInitial;
  AttendanceStatus status;

  Student({
    required this.id,
    required this.name,
    this.status = AttendanceStatus.pending,
  }) : avatarInitial = name.isNotEmpty ? name[0].toUpperCase() : '?';
}

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Dummy data - in a real app, this would come from a database.
  final List<Student> _students = [
    Student(id: '1', name: 'Revanth Rampal'),
    Student(id: '2', name: 'Alex Johnson'),
    Student(id: '3', name: 'Maria Garcia'),
    Student(id: '4', name: 'Chen Wei'),
    Student(id: '5', name: 'Fatima Al-Sayed'),
    Student(id: '6', name: 'David Smith'),
  ];

  DateTime _selectedDate = DateTime.now();
  String _selectedClass = 'Class 10-A';

  // Function to show the date picker dialog.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Helper widget to get the right icon and color for the attendance status.
  Widget _getStatusIcon(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return const Icon(Icons.check_circle, color: Colors.green);
      case AttendanceStatus.absent:
        return const Icon(Icons.cancel, color: Colors.red);
      default: // Pending
        return const Icon(Icons.hourglass_empty, color: Colors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Attendance'),
      ),
      body: Column(
        children: [
          // Header section with Class and Date selection.
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedClass,
                    items: <String>['Class 10-A', 'Class 10-B', 'Class 11-C']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedClass = newValue;
                        });
                      }
                    },
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_today, size: 18),
                  label: Text(DateFormat.yMMMd().format(_selectedDate)),
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          // Scrollable list of students.
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Text(
                        student.avatarInitial,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(student.name),
                    trailing: _getStatusIcon(student.status),
                  ),
                );
              },
            ),
          ),
          // Footer section with the primary action button.
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                // Navigate to the camera screen for scanning.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CameraScanScreen()),
                );
              },
              label: const Text('Start Camera Scan'),
            ),
          ),
        ],
      ),
    );
  }
}
