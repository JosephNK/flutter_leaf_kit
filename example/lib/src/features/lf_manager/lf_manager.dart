import 'package:example/src/common/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import 'file/ui/file_screen.dart';

class LFManagerScreen extends StatelessWidget {
  final String title;

  const LFManagerScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    List<ListItem> items = [
      ListItem(id: 'file', title: 'FileScreen'),
    ];

    return Scaffold(
      appBar: LFAppBar(
        title: LFAppBarTitle(text: title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final id = item.id;
          final title = item.title;

          return ListTile(
            title: Text(title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 15.0),
            onTap: () async {
              late Widget screen;

              switch (id) {
                case 'file':
                  screen = FileScreen(title: title);
                  break;
              }

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
