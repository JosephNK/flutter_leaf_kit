part of leaf_container_component;

class LeafDottedBorder extends StatelessWidget {
  final Color color;
  final Widget child;

  const LeafDottedBorder({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: color,
      strokeWidth: 1,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: child,
    );
  }
}
