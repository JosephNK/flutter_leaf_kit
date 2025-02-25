import 'package:example/src/common/list_item.dart';
import 'package:flutter/cupertino.dart';

import '../../common/interface_index.dart';
import 'ui/accordion/ui/accordion_screen.dart';
import 'ui/animation/ui/animation_screen.dart';
import 'ui/avatar/ui/avatar_screen.dart';
import 'ui/badge/ui/badge_screen.dart';
import 'ui/bottomsheet/ui/bottomsheet_screen.dart';
import 'ui/bottomtabbar/ui/bottomtabbar_screen.dart';
import 'ui/button/ui/button_screen.dart';
import 'ui/calendar/ui/calendar_screen.dart';
import 'ui/checkbox/ui/checkbox_screen.dart';
import 'ui/chip/ui/chip_screen.dart';
import 'ui/datetime/ui/datetime_screen.dart';
import 'ui/dialog/ui/dialog_screen.dart';
import 'ui/empty/ui/empty_screen.dart';
import 'ui/gridview/ui/gridview_screen.dart';
import 'ui/image/ui/image_screen.dart';
import 'ui/indicator/ui/indicator_screen.dart';
import 'ui/listview/ui/listview_screen.dart';
import 'ui/notification/ui/notificaion_screen.dart';
import 'ui/pageindicator/ui/page_indicator_screen.dart';
import 'ui/paveview/ui/pageview_screen.dart';
import 'ui/photo/ui/photo_screen.dart';
import 'ui/radio/ui/radio_screen.dart';
import 'ui/scroll/ui/scroll_screen.dart';
import 'ui/slider/ui/slider_screen.dart';
import 'ui/switch/ui/switch_screen.dart';
import 'ui/tabbar/tabbar_sceen.dart';
import 'ui/text/ui/text_screen.dart';
import 'ui/textfield/textfield_sceen.dart';
import 'ui/toast/ui/toast_screen.dart';
import 'ui/webview/ui/webview_screen.dart';

class Index implements InterfaceIndex {
  List<ListItem> items = [
    ListItem(id: 'accordion', title: 'AccordionScreen'),
    ListItem(id: 'animation', title: 'AnimationScreen'),
    ListItem(id: 'avatar', title: 'AvatarScreen'),
    ListItem(id: 'badge', title: 'BadgeScreen'),
    ListItem(id: 'bottomsheet', title: 'BottomSheetScreen'),
    ListItem(id: 'bottomtabbar', title: 'BottomTabBarScreen'),
    ListItem(id: 'button', title: 'ButtonScreen'),
    ListItem(id: 'calendar', title: 'CalendarScreen'),
    ListItem(id: 'checkbox', title: 'CheckboxScreen'),
    ListItem(id: 'chip', title: 'ChipScreen'),
    ListItem(id: 'datetime', title: 'DateTimeScreen'),
    ListItem(id: 'dialog', title: 'DialogScreen'),
    ListItem(id: 'empty', title: 'EmptyScreen'),
    ListItem(id: 'image', title: 'ImageScreen'),
    ListItem(id: 'indicator', title: 'IndicatorScreen'),
    ListItem(id: 'pageindicator', title: 'PageIndicatorScreen'),
    ListItem(id: 'pageview', title: 'PageViewScreen'),
    ListItem(id: 'photo', title: 'PhotoScreen'),
    ListItem(id: 'radio', title: 'RadioScreen'),
    ListItem(id: 'scroll', title: 'ScrollScreen'),
    ListItem(id: 'slider', title: 'SliderScreen'),
    ListItem(id: 'text', title: 'TextScreen'),
    ListItem(id: 'textfield', title: 'TextFieldScreen'),
    ListItem(id: 'toast', title: 'ToastScreen'),
    ListItem(id: 'tabbar', title: 'TabbarScreen'),
    ListItem(id: 'switch', title: 'SwitchScreen'),
    ListItem(id: 'notification', title: 'NotificationScreen'),
    ListItem(id: 'listview', title: 'ListViewScreen'),
    ListItem(id: 'gridview', title: 'GridViewScreen'),
    ListItem(id: 'webview', title: 'WebViewScreen'),
  ]..sort((a, b) => a.id.compareTo(b.id));

  @override
  Widget getScreen(ListItem item) {
    final id = item.id;
    final title = item.title;

    late Widget screen;

    switch (id) {
      case 'accordion':
        screen = AccordionScreen(title: title);
        break;
      case 'animation':
        screen = AnimationScreen(title: title);
        break;
      case 'avatar':
        screen = AvatarScreen(title: title);
        break;
      case 'badge':
        screen = BadgeScreen(title: title);
        break;
      case 'bottomsheet':
        screen = BottomSheetScreen(title: title);
        break;
      case 'bottomtabbar':
        screen = BottomTabBarScreen(title: title);
        break;
      case 'button':
        screen = ButtonScreen(title: title);
        break;
      case 'calendar':
        screen = CalendarScreen(title: title);
        break;
      case 'checkbox':
        screen = CheckboxScreen(title: title);
        break;
      case 'chip':
        screen = ChipScreen(title: title);
        break;
      case 'datetime':
        screen = DateTimeScreen(title: title);
        break;
      case 'dialog':
        screen = DialogScreen(title: title);
        break;
      case 'empty':
        screen = EmptyScreen(title: title);
        break;
      case 'image':
        screen = ImageScreen(title: title);
        break;
      case 'indicator':
        screen = IndicatorScreen(title: title);
        break;
      case 'pageindicator':
        screen = PageIndicatorScreen(title: title);
        break;
      case 'pageview':
        screen = PageViewScreen(title: title);
        break;
      case 'photo':
        screen = PhotoScreen(title: title);
        break;
      case 'radio':
        screen = RadioScreen(title: title);
        break;
      case 'scroll':
        screen = ScrollScreen(title: title);
        break;
      case 'slider':
        screen = SliderScreen(title: title);
        break;
      case 'text':
        screen = TextScreen(title: title);
        break;
      case 'textfield':
        screen = TextFieldScreen(title: title);
        break;
      case 'tabbar':
        screen = TabBarScreen(title: title);
        break;
      case 'toast':
        screen = ToastScreen(title: title);
        break;
      case 'switch':
        screen = SwitchScreen(title: title);
        break;
      case 'notification':
        screen = NotificationScreen(title: title);
        break;
      case 'listview':
        screen = ListViewScreen(title: title);
        break;
      case 'gridview':
        screen = GridViewScreen(title: title);
        break;
      case 'webview':
        screen = WebViewScreen(title: title);
        break;
    }

    return screen;
  }
}
