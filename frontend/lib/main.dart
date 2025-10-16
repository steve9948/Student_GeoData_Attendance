import 'package:flutter/material.dart';
import 'package:university_student_geodata/screens/admin/admin_dashboard.dart';
import 'package:university_student_geodata/screens/admin_redirect.dart';
import 'package:university_student_geodata/screens/lecturer_dashboard.dart';
import 'package:university_student_geodata/screens/login_screen.dart';
import 'package:university_student_geodata/screens/student_home.dart';
import 'package:university_student_geodata/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GFAMS',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard-screen': (context) => const StudentHomeScreen(),
        '/lecturer-dashboard': (context) => const LecturerDashboardScreen(),
        '/admin-redirect': (context) => const AdminRedirectScreen(),
        '/admin-dashboard': (context) => const AdminDashboard(),
      },
    );
  }
}
