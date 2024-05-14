part of '../accordion.dart';

class LFAccordionItem<T> {
  final String section;
  final T data;
  final String? subtitle;

  LFAccordionItem({
    required this.section,
    required this.data,
    this.subtitle,
  });
}
