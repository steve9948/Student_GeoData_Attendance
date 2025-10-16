import 'package:flutter/material.dart';

class SsoLoginWidget extends StatelessWidget {
  final VoidCallback onSsoLogin;
  final bool isLoading;

  const SsoLoginWidget({super.key, required this.onSsoLogin, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onSsoLogin,
      icon: const Icon(Icons.shield_outlined), // Example SSO icon
      label: const Text('Sign in with SSO'),
    );
  }
}
