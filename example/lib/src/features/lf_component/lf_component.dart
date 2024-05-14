import 'package:example/src/common/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import 'accordion/ui/accordion_screen.dart';
import 'animation/ui/animation_screen.dart';
import 'avatar/ui/avatar_screen.dart';
import 'badge/ui/badge_screen.dart';
import 'bottomsheet/ui/bottomsheet_screen.dart';
import 'bottomtabbar/ui/bottomtabbar_screen.dart';
import 'calendar/ui/calendar_screen.dart';
import 'checkbox/ui/checkbox_screen.dart';
import 'chip/ui/chip_screen.dart';
import 'dialog/ui/dialog_screen.dart';
import 'empty/ui/empty_screen.dart';
import 'image/ui/image_screen.dart';
import 'indicator/ui/indicator_screen.dart';
import 'pageindicator/ui/page_indicator_screen.dart';
import 'paveview/ui/pageview_screen.dart';
import 'photo/ui/photo_screen.dart';
import 'radio/ui/radio_screen.dart';
import 'scroll/ui/scroll_screen.dart';
import 'slider/ui/slider_screen.dart';
import 'text/ui/text_screen.dart';
import 'textfield/textfield_sceen.dart';

class LFComponentScreen extends StatelessWidget {
  final String title;

  const LFComponentScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    List<ListItem> items = [
      ListItem(id: 'accordion', title: 'AccordionScreen'),
      ListItem(id: 'animation', title: 'AnimationScreen'),
      ListItem(id: 'avatar', title: 'AvatarScreen'),
      ListItem(id: 'badge', title: 'BadgeScreen'),
      ListItem(id: 'bottomsheet', title: 'BottomSheetScreen'),
      ListItem(id: 'bottomtabbar', title: 'BottomTabBarScreen'),
      ListItem(id: 'calendar', title: 'CalendarScreen'),
      ListItem(id: 'checkbox', title: 'CheckboxScreen'),
      ListItem(id: 'chip', title: 'ChipScreen'),
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
                case 'calendar':
                  screen = CalendarScreen(title: title);
                  break;
                case 'checkbox':
                  screen = CheckboxScreen(title: title);
                  break;
                case 'chip':
                  screen = ChipScreen(title: title);
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
