import 'package:flutter/widgets.dart';

class ComponentItem {
  const ComponentItem({
    required this.id,
    required this.title,
    required this.builder,
  });

  final String id;
  final String title;
  final WidgetBuilder builder;
}
