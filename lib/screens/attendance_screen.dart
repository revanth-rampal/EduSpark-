import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // A package to help with date formatting

// A simple model for our student data
class Student {
  final String id;
  final String name;
  bool isPresent;

  Student({required this.id, required this.name, this.isPresent = true});
}

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Dummy data - in a real app, this would come from a database
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Attendance'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Header with Class and Date selection
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Class Dropdown
                DropdownButton<String>(
                  value: _selectedClass,
                  items: <String>['Class 10-A', 'Class 10-B', 'Class 11-C']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedClass = newValue!;
                    });
                  },
                ),
                // Date Picker
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18),
                      const SizedBox(width: 8),
                      Text(DateFormat.yMMMd().format(_selectedDate)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Student List
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      child: Text(student.name[0]), // First initial
                    ),
                    title: Text(student.name),
                    // Checkbox to mark attendance
                    trailing: Checkbox(
                      value: student.isPresent,
                      onChanged: (bool? value) {
                        setState(() {
                          student.isPresent = value!;
                        });
                      },
                      activeColor: Colors.indigo,
                    ),
                  ),
                );
              },
            ),
          ),
          // Submit Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Placeholder for submitting attendance
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Attendance submitted successfully!')),
                );
                Navigator.pop(context); // Go back to the dashboard
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Submit Attendance'),
            ),
          ),
        ],
      ),
    );
  }
}
