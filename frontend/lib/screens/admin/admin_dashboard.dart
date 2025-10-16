import 'package:flutter/material.dart';
import 'package:university_student_geodata/screens/admin/overview_screen.dart';
import 'package:university_student_geodata/screens/admin/departments_screen.dart';
import 'package:university_student_geodata/screens/admin/admissions_screen.dart';
import 'package:university_student_geodata/screens/admin/staff_screen.dart';
import 'package:university_student_geodata/screens/admin/presence_map_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const OverviewScreen(),
    const DepartmentsScreen(),
    const AdmissionsScreen(),
    const StaffScreen(),
    const PresenceMapScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_outlined),
            label: 'Departments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1_outlined),
            label: 'Admissions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Staff',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Presence',
          ),
        ],
      ),
    );
  }
}
