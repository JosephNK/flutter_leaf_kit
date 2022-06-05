part of leaf_container_component;

class LeafTransparentContainer extends StatelessWidget {
  const LeafTransparentContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
    );
  }
}
