import 'package:flutter/foundation.dart';

@immutable
class LFAccordionItemV2<T> {
  final String title;
  final T data;
  final String? subtitle;

  const LFAccordionItemV2({
    required this.title,
    required this.data,
    this.subtitle,
  });
}
