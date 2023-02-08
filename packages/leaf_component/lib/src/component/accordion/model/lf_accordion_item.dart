part of lf_accordion;

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
