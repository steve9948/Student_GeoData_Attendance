import 'package:flutter/material.dart';
import 'package:university_student_geodata/services/api_service.dart';
import 'package:university_student_geodata/services/location_service.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final LocationService _locationService = LocationService();
  final ApiService _apiService = ApiService();

  String _statusMessage = 'Press the button to mark your attendance';
  bool _isLoading = false;

  Future<void> _markAttendance() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Getting your location...';
    });

    try {
      // 1. Get current location
      final position = await _locationService.getCurrentPosition();
      setState(() {
        _statusMessage = 'Location found. Verifying with server...';
      });

      // 2. Send location to the backend for geofence validation
      final responseMessage = await _apiService.markAttendance(position);

      // 3. Display the backend's response
      setState(() {
        _statusMessage = responseMessage;
      });
    } catch (e) {
      setState(() {
        _statusMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          // Logout Button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // In a real app, you should also clear the auth token here
              Navigator.of(context).pushReplacementNamed('/');
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome, Student!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Text(
                'Status: $_statusMessage',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: _markAttendance,
                      icon: const Icon(Icons.location_on_outlined),
                      label: const Text('MARK MY ATTENDANCE'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
