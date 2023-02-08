part of lf_accordion;

typedef LFAccordionItemBuilder<T> = Widget Function(
  BuildContext context,
  int index,
  T item,
);

class LFAccordion<T> extends StatelessWidget {
  final List<LFAccordionItem<T>> items;
  final LFAccordionItemBuilder<T> itemBuilder;
  final int? expandIndex;
  final Color? borderColor;

  const LFAccordion({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.expandIndex,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = this.items;
    final itemBuilder = this.itemBuilder;
    final expandIndex = this.expandIndex;
    final borderColor = this.borderColor;

    return SingleChildScrollView(
      child: Column(
        children: [
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final title = item.section;
            final subtitle = item.subtitle;
            final data = item.data;

            final widget = itemBuilder(context, index, data);

            return LFAccordionTile(
              expand: index == expandIndex,
              title: title,
              subtitle: subtitle,
              borderColor: borderColor,
              child: widget,
            );
          })
        ],
      ),
    );
  }
}
