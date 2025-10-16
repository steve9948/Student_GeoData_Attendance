import 'package:flutter/material.dart';
import 'package:university_student_geodata/screens/admin/create_lecture_screen.dart';

class LecturerDashboardScreen extends StatelessWidget {
  const LecturerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecturer Dashboard'),
        actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: <Widget>[
            _buildDashboardCard(
              context,
              icon: Icons.add_circle_outline,
              label: 'Create Lecture',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateLectureScreen()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.playlist_add_check,
              label: 'Manual Attendance',
              onTap: () {
                // TODO: Navigate to Manual Attendance Screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Manual Attendance feature coming soon!')),
                );
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.history,
              label: 'Past Lectures',
              onTap: () {
                // TODO: Navigate to Past Lectures Screen
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.bar_chart_outlined,
              label: 'View Reports',
              onTap: () {
                // TODO: Navigate to Reports Screen
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 48.0, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
