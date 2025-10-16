import 'package:flutter/material.dart';

class RegisterLinkWidget extends StatelessWidget {
  final VoidCallback onRegisterTap;

  const RegisterLinkWidget({super.key, required this.onRegisterTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRegisterTap,
      child: const Text('Don\'t have an account? Register'),
    );
  }
}
