import 'package:flutter/material.dart';

enum ComponentCategory {
  atoms('Atoms', Icons.widgets_outlined),
  molecules('Molecules', Icons.extension_outlined),
  organisms('Organisms', Icons.dashboard_outlined),
  templates('Templates', Icons.web_outlined);

  const ComponentCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
