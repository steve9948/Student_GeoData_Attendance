import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UniversityLogoWidget extends StatelessWidget {
  const UniversityLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // A fixed height for a more consistent layout
      child: SvgPicture.asset(
        'assets/KCAU-logo.svg', // Explicitly using the full path
        semanticsLabel: 'University Logo',
      ),
    );
  }
}
