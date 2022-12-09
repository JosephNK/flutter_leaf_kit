import 'package:example/src/manager/navigator_manager.dart';
import 'package:example/src/model/classes/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ListItem> _items = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final items = await NavigatorManagerLoader.loadAssets();
      setState(() {
        _items = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LFAppBar(
        title: LFAppBarTitle(text: 'Example'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          final title = item.title;

          return ListTile(
            title: Text(title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 15.0),
            onTap: () async {
              await NavigatorManager.shared.push(context, item: item);
            },
          );
        },
      ),
    );
  }
}
