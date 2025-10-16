import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  final Function(String, String) onLogin;
  final bool isLoading;
  final String userTypeLabel;

  const LoginFormWidget({
    super.key,
    required this.onLogin,
    required this.isLoading,
    required this.userTypeLabel,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: '${widget.userTypeLabel} ID / Email',
              prefixIcon: const Icon(Icons.person_outline),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.isLoading
                ? null
                : () => widget.onLogin(_emailController.text, _passwordController.text),
            child: widget.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('LOGIN'),
          ),
        ],
      ),
    );
  }
}
