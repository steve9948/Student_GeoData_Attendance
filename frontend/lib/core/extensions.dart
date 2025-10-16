import 'package:flutter/widgets.dart';

/// A utility class for getting screen dimensions.
class SizerUtil {
  static late double _width;
  static late double _height;

  /// Initializes the SizerUtil with the screen dimensions from the given [context].
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
  }
}

/// An extension on [num] to provide responsive sizing.
extension SizerExt on num {
  /// Calculates the height based on the screen height.
  ///
  /// For example, `50.h` will be 50% of the screen height.
  double get h => (this / 100) * SizerUtil._height;

  /// Calculates the width based on the screen width.
  ///
  /// For example, `50.w` will be 50% of the screen width.
  double get w => (this / 100) * SizerUtil._width;
}