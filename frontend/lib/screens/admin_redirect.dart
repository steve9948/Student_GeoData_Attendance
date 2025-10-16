import 'package:flutter/material.dart';

class AdminRedirectScreen extends StatelessWidget {
  const AdminRedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This would ideally redirect to a web portal.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Redirect'),
      ),
      body: const Center(
        child: Text('Redirecting to admin web portal...'),
      ),
    );
  }
}
