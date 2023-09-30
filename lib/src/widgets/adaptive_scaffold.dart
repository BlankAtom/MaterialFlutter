import 'package:flutter/material.dart';

const double _largeScreenWidthParameter = 960.0;
const double _smallScreenWidthParameter = 960.0;

bool _isLargeScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > _largeScreenWidthParameter;
}

bool _isSmallScreen(BuildContext context) {
  return MediaQuery.of(context).size.width < _smallScreenWidthParameter;
}

class AdaptiveScaffoldDestination {
  final String title;
  final IconData icon;

  const AdaptiveScaffoldDestination({required this.title, required this.icon});
}
