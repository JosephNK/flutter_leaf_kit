import 'package:flutter/foundation.dart';

@immutable
class LeafAccordionItem<T> {
  final String title;
  final T data;
  final String? subtitle;

  const LeafAccordionItem({
    required this.title,
    required this.data,
    this.subtitle,
  });
}
