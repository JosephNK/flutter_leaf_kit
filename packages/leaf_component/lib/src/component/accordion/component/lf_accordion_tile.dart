part of '../lf_accordion.dart';

class LFAccordionTile extends StatefulWidget {
  final String title;
  final Widget child;
  final bool? expand;
  final String? subtitle;
  final Color? borderColor;

  const LFAccordionTile({
    super.key,
    required this.title,
    required this.child,
    this.expand,
    this.subtitle,
    this.borderColor,
  });

  @override
  State<LFAccordionTile> createState() => _LFAccordionTileState();
}

class _LFAccordionTileState extends State<LFAccordionTile> {
  bool _expand = false;

  @override
  void initState() {
    super.initState();

    final expand = widget.expand;
    if (expand != null) {
      _expand = expand;
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final subtitle = widget.subtitle;
    final borderColor = widget.borderColor;
    final child = widget.child;

    return Column(
      children: [
        LFAccordionSection(
          expand: _expand,
          title: title,
          subtitle: subtitle,
          borderColor: borderColor,
          onPressed: (expand) {
            setState(() {
              _expand = expand;
            });
          },
        ),
        LFAccordionContent(
          expand: _expand,
          child: child,
        ),
      ],
    );
  }
}
