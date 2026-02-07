import 'package:flutter/material.dart';

enum ComponentCategory {
  atoms('Basic Elements', Icons.widgets_outlined),
  styled('Styled Widgets', Icons.brush_outlined),
  containers('Containers', Icons.inventory_2_outlined),
  pickers('Pickers & Dialogs', Icons.calendar_month_outlined),
  navigation('Navigation', Icons.navigation_outlined),
  scroll('Scrollable Lists', Icons.view_list_outlined),
  layout('Layout & Utilities', Icons.grid_view_outlined);

  const ComponentCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
