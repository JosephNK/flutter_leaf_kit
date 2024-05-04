import 'package:example/src/common/model/classes/list_item.dart';
import 'package:flutter/material.dart';

import '../../features/_sub/ui/accordion_screen.dart';
import '../../features/_sub/ui/animation_screen.dart';
import '../../features/_sub/ui/avatar_screen.dart';
import '../../features/_sub/ui/badge_screen.dart';
import '../../features/_sub/ui/bottomsheet_screen.dart';
import '../../features/_sub/ui/button_screen.dart';
import '../../features/_sub/ui/calendar_screen.dart';
import '../../features/_sub/ui/checkbox_screen.dart';
import '../../features/_sub/ui/chip_screen.dart';
import '../../features/_sub/ui/dialog_screen.dart';
import '../../features/_sub/ui/indicator_screen.dart';
import '../../features/_sub/ui/navigationbar_screen.dart';
import '../../features/_sub/ui/pageview_screen.dart';
import '../../features/_sub/ui/photo_screen.dart';
import '../../features/_sub/ui/radio_screen.dart';
import '../../features/_sub/ui/slider_screen.dart';
import '../../features/image/ui/image_screen.dart';
import '../../features/network/ui/network_screen.dart';
import '../../features/page_indicator/ui/page_indicator_screen.dart';
import '../../features/scroll/ui/scroll_screen.dart';
import '../../features/text/ui/text_screen.dart';
import '../../features/textfield/textfield_sceen.dart';

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
    {"id": "Image", "title": "Image"},
    {"id": "PageIndicator", "title": "PageIndicator"},
    {"id": "Text", "title": "Text"},
    {"id": "Scroll", "title": "Scroll"},
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
      case 'Image':
        widget = ImageScreen(title: title);
        break;
      case 'PageIndicator':
        widget = PageIndicatorScreen(title: title);
        break;
      case 'Text':
        widget = TextScreen(title: title);
        break;
      case 'Scroll':
        widget = ScrollScreen(title: title);
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
