import 'package:example/src/common/manager/navigator_manager.dart';
import 'package:example/src/common/model/classes/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_leaf_component/leaf_component.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

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
      appBar: LFAppBar(
        title: LFAppBarTitle(text: 'Example ${'L10N_HELLO'.tr()}'),
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
