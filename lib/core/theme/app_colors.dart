import 'package:flutter/material.dart';

/// Brand palette. The [seed] drives the Material 3 [ColorScheme]; add semantic
/// colors here as the design system grows.
abstract final class AppColors {
  const AppColors._();

  static const Color seed = Color(0xFF6750A4);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color danger = Color(0xFFC62828);
}
