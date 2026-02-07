import 'package:flutter/widgets.dart';

class PackageEntry {
  const PackageEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.builder,
    this.enabled = true,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;
  final bool enabled;
}
