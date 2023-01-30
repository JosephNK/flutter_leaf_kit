import 'package:example/src/model/classes/list_item.dart';
import 'package:flutter/material.dart';

import '../ui/screens/accordion_screen.dart';
import '../ui/screens/animation_screen.dart';
import '../ui/screens/avatar_screen.dart';
import '../ui/screens/badge_screen.dart';
import '../ui/screens/bottomsheet_screen.dart';
import '../ui/screens/button_screen.dart';
import '../ui/screens/calendar_screen.dart';
import '../ui/screens/checkbox_screen.dart';
import '../ui/screens/chip_screen.dart';
import '../ui/screens/dialog_screen.dart';
import '../ui/screens/indicator_screen.dart';
import '../ui/screens/navigationbar_screen.dart';
import '../ui/screens/network_screen.dart';
import '../ui/screens/pageview_screen.dart';
import '../ui/screens/photo_screen.dart';
import '../ui/screens/radio_screen.dart';
import '../ui/screens/slider_screen.dart';
import '../ui/screens/textfield_sceen.dart';

dynamic kListObjects = {
  "items": [
    {"id": "Avatar", "title": "Avatar"},
    {"id": "Network", "title": "Network"},
    {"id": "NavigationBar", "title": "NavigationBar"},
    {"id": "Badge", "title": "Badge"},
    {"id": "Button", "title": "Button"},
    {"id": "CheckBox", "title": "CheckBox"},
    {"id": "Radio", "title": "Radio"},
    {"id": "Dialog", "title": "Dialog"},
    {"id": "Accordion", "title": "Accordion"},
    {"id": "Indicator", "title": "Indicator"},
    {"id": "Chip", "title": "Chip"},
    {"id": "PageView", "title": "PageView"},
    {"id": "TextField", "title": "TextField"},
    {"id": "BottomSheet", "title": "BottomSheet"},
    {"id": "Slider", "title": "Slider"},
    {"id": "Calendar", "title": "Calendar"},
    {"id": "Photo", "title": "Photo"},
    {"id": "Animation", "title": "Animation"},
  ]
};

class NavigatorManager {
  static final NavigatorManager _instance = NavigatorManager._internal();

  static NavigatorManager get shared => _instance;

  NavigatorManager._internal();

  Future<dynamic> push(BuildContext context, {required ListItem item}) {
    final title = item.title;

    late Widget widget;

    switch (title) {
      case 'Avatar':
        widget = AvatarScreen(title: title);
        break;
      case 'Network':
        widget = NetworkScreen(title: title);
        break;
      case 'NavigationBar':
        widget = BottomNavigationBarScreen(title: title);
        break;
      case 'Badge':
        widget = BadgeScreen(title: title);
        break;
      case 'Button':
        widget = ButtonScreen(title: title);
        break;
      case 'CheckBox':
        widget = CheckboxScreen(title: title);
        break;
      case 'Radio':
        widget = RadioScreen(title: title);
        break;
      case 'Dialog':
        widget = DialogScreen(title: title);
        break;
      case 'Accordion':
        widget = AccordionScreen(title: title);
        break;
      case 'Indicator':
        widget = IndicatorScreen(title: title);
        break;
      case 'Chip':
        widget = ChipScreen(title: title);
        break;
      case 'PageView':
        widget = PageViewScreen(title: title);
        break;
      case 'TextField':
        widget = TextFieldScreen(title: title);
        break;
      case 'BottomSheet':
        widget = BottomSheetScreen(title: title);
        break;
      case 'Slider':
        widget = SliderScreen(title: title);
        break;
      case 'Calendar':
        widget = CalendarScreen(title: title);
        break;
      case 'Photo':
        widget = PhotoScreen(title: title);
        break;
      case 'Animation':
        widget = AnimationScreen(title: title);
        break;
    }

    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}

extension NavigatorManagerLoader on NavigatorManager {
  static Future<List<ListItem>> loadAssets() async {
    dynamic jsonString = kListObjects;
    if (jsonString != null) {
      final items = (jsonString['items'] as List)
          .map((json) => ListItem.fromJson(json))
          .toList();
      items.sort((a, b) => a.title.compareTo(b.title));
      return items;
    }
    return [];
  }
}
