import 'package:flutter/material.dart';

const Color primaryColor       = Color(0xFF6C63FF);
const Color secondaryColor     = Color(0xFF32D74B);
const Color accentColor        = Color(0xFFFF6B6B);
const Color backgroundColor    = Color(0xFFF7F9FC);
const Color surfaceColor       = Color(0xFFFFFFFF);
const Color textPrimaryColor   = Color(0xFF2D3748);
const Color textSecondaryColor = Color(0xFF718096);
const Color errorColor         = Color(0xFFE53E3E);

const LinearGradient primaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [primaryColor, Color(0xFF00FFFF)],
);

final List<BoxShadow> softShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 10,
    offset: Offset(0, 4),
  ),
];
