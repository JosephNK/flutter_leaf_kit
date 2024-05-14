import 'package:example/src/common/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../index.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ListItem> items = Index().items;

    return Scaffold(
      appBar: LFAppBar(
        title: LFAppBarTitle(text: 'Example - ${'L10N_SAMPLE'.tr()}'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final title = item.title;

          return ListTile(
            title: Text(title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 15.0),
            onTap: () async {
              Widget screen = Index().getScreen(item);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screen),
              );
            },
          );
        },
      ),
    );
  }
}
