import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_component.dart';

class WidgetTile extends StatelessWidget {
  final String title;
  final Widget child;

  const WidgetTile({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: LFText(
                    title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Center(child: child),
        ],
      ),
    );
  }
}
