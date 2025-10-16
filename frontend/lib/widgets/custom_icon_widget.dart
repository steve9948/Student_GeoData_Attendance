import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  final String iconName;
  final Color color;
  final double size;

  const CustomIconWidget({
    super.key,
    required this.iconName,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      _getIcon(iconName),
      color: color,
      size: size,
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'error_outline':
        return Icons.error_outline;
      case 'close':
        return Icons.close;
      default:
        return Icons.help;
    }
  }
}
