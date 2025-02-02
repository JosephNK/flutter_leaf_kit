import 'package:example/src/common/list_item.dart';
import 'package:flutter/cupertino.dart';

import '../../common/interface_index.dart';
import '../lf_component/ui/lf_component.dart';
import '../lf_manager/ui/lf_manager.dart';
import '../lf_network/ui/lf_network.dart';
import '../lf_store/ui/lf_store.dart';

class Index implements InterfaceIndex {
  List<ListItem> items = [
    ListItem(id: 'lf_component', title: 'LF_COMPONENT'),
    ListItem(id: 'lf_manager', title: 'LF_MANAGER'),
    ListItem(id: 'lf_network', title: 'LF_NETWORK'),
    ListItem(id: 'lf_store', title: 'LF_STORE'),
  ]..sort((a, b) => a.id.compareTo(b.id));

  @override
  Widget getScreen(ListItem item) {
    final id = item.id;
    final title = item.title;

    late Widget screen;

    switch (id) {
      case 'lf_component':
        screen = LFComponentScreen(title);
        break;
      case 'lf_manager':
        screen = LFManagerScreen(title);
        break;
      case 'lf_network':
        screen = LFNetworkScreen(title);
        break;
      case 'lf_store':
        screen = LFStoreScreen(title);
        break;
    }

    return screen;
  }
}
