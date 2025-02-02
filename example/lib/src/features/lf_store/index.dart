import 'package:example/src/common/list_item.dart';
import 'package:flutter/cupertino.dart';

import '../../common/interface_index.dart';
import 'ui/store/ui/store_screen.dart';

class Index implements InterfaceIndex {
  List<ListItem> items = [
    ListItem(id: 'store', title: 'StoreScreen'),
  ]..sort((a, b) => a.id.compareTo(b.id));

  @override
  Widget getScreen(ListItem item) {
    final id = item.id;
    final title = item.title;

    late Widget screen;

    switch (id) {
      case 'store':
        screen = StoreScreen(title: title);
        break;
    }

    return screen;
  }
}
