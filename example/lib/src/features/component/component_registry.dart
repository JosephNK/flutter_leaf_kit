import '../../common/models/component_category.dart';
import '../../common/models/component_item.dart';
import 'screens/atoms/badge_screen.dart';
import 'screens/atoms/checkbox_screen.dart';
import 'screens/atoms/chip_screen.dart';
import 'screens/atoms/indicator_screen.dart';
import 'screens/atoms/radio_screen.dart';
import 'screens/atoms/skeleton_screen.dart';
import 'screens/atoms/switch_screen.dart';
import 'screens/containers/accordion_screen.dart';
import 'screens/containers/appbar_screen.dart';
import 'screens/containers/bottomsheet_screen.dart';
import 'screens/containers/notification_screen.dart';
import 'screens/containers/page_screen.dart';
import 'screens/containers/tabs_screen.dart';
import 'screens/containers/toast_screen.dart';
import 'screens/layout/app_layout_screen.dart';
import 'screens/layout/grid_staggered_screen.dart';
import 'screens/layout/painter_screen.dart';
import 'screens/layout/screen_base_screen.dart';
import 'screens/layout/size_screen.dart';
import 'screens/navigation/navigationbar_screen.dart';
import 'screens/navigation/popscope_screen.dart';
import 'screens/pickers/calendar_screen.dart';
import 'screens/pickers/dialog_screen.dart';
import 'screens/pickers/picker_screen.dart';
import 'screens/scroll/aligned_gridview_screen.dart';
import 'screens/scroll/gridview_screen.dart';
import 'screens/scroll/listview_screen.dart';
import 'screens/scroll/scrollview_screen.dart';
import 'screens/styled/animated_screen.dart';
import 'screens/styled/button_screen.dart';
import 'screens/styled/icon_screen.dart';
import 'screens/styled/image_screen.dart';
import 'screens/styled/ratingbar_screen.dart';
import 'screens/styled/slider_screen.dart';
import 'screens/styled/text_screen.dart';
import 'screens/styled/textfield_screen.dart';

final Map<ComponentCategory, List<ComponentItem>> componentRegistry = {
  ComponentCategory.atoms: [
    ComponentItem(
      id: 'badge',
      title: 'Badge',
      builder: (_) => const BadgeScreen(),
    ),
    ComponentItem(
      id: 'checkbox',
      title: 'CheckBox',
      builder: (_) => const CheckboxScreen(),
    ),
    ComponentItem(
      id: 'radio',
      title: 'Radio',
      builder: (_) => const RadioScreen(),
    ),
    ComponentItem(
      id: 'switch',
      title: 'Switch',
      builder: (_) => const SwitchScreen(),
    ),
    ComponentItem(
      id: 'chip',
      title: 'Chip',
      builder: (_) => const ChipScreen(),
    ),
    ComponentItem(
      id: 'indicator',
      title: 'Indicator',
      builder: (_) => const IndicatorScreen(),
    ),
    ComponentItem(
      id: 'skeleton',
      title: 'Skeleton',
      builder: (_) => const SkeletonScreen(),
    ),
  ],
  ComponentCategory.styled: [
    ComponentItem(
      id: 'button',
      title: 'Button',
      builder: (_) => const ButtonScreen(),
    ),
    ComponentItem(
      id: 'text',
      title: 'Text',
      builder: (_) => const TextScreen(),
    ),
    ComponentItem(
      id: 'textfield',
      title: 'TextField',
      builder: (_) => const TextFieldScreen(),
    ),
    ComponentItem(
      id: 'slider',
      title: 'Slider',
      builder: (_) => const SliderScreen(),
    ),
    ComponentItem(
      id: 'icon',
      title: 'Icon',
      builder: (_) => const IconScreen(),
    ),
    ComponentItem(
      id: 'ratingbar',
      title: 'Rating Bar',
      builder: (_) => const RatingBarScreen(),
    ),
    ComponentItem(
      id: 'image',
      title: 'Image',
      builder: (_) => const ImageScreen(),
    ),
    ComponentItem(
      id: 'animated',
      title: 'Animated',
      builder: (_) => const AnimatedScreen(),
    ),
  ],
  ComponentCategory.containers: [
    ComponentItem(
      id: 'appbar',
      title: 'AppBar',
      builder: (_) => const AppBarScreen(),
    ),
    ComponentItem(
      id: 'tabs',
      title: 'Tabs',
      builder: (_) => const TabsScreen(),
    ),
    ComponentItem(
      id: 'accordion',
      title: 'Accordion',
      builder: (_) => const AccordionScreen(),
    ),
    ComponentItem(
      id: 'page',
      title: 'PageView',
      builder: (_) => const PageScreen(),
    ),
    ComponentItem(
      id: 'bottomsheet',
      title: 'Bottom Sheet',
      builder: (_) => const BottomSheetScreen(),
    ),
    ComponentItem(
      id: 'toast',
      title: 'Toast',
      builder: (_) => const ToastScreen(),
    ),
    ComponentItem(
      id: 'notification',
      title: 'Notification',
      builder: (_) => const NotificationScreen(),
    ),
  ],
  ComponentCategory.pickers: [
    ComponentItem(
      id: 'dialog',
      title: 'Dialog',
      builder: (_) => const DialogScreen(),
    ),
    ComponentItem(
      id: 'picker',
      title: 'Picker',
      builder: (_) => const PickerScreen(),
    ),
    ComponentItem(
      id: 'calendar',
      title: 'Calendar',
      builder: (_) => const CalendarScreen(),
    ),
  ],
  ComponentCategory.navigation: [
    ComponentItem(
      id: 'navigationbar',
      title: 'Navigation Bar',
      builder: (_) => const NavigationBarScreen(),
    ),
    ComponentItem(
      id: 'popscope',
      title: 'PopScope',
      builder: (_) => const PopScopeScreen(),
    ),
  ],
  ComponentCategory.scroll: [
    ComponentItem(
      id: 'listview',
      title: 'ListView',
      builder: (_) => const ListViewScreen(),
    ),
    ComponentItem(
      id: 'gridview',
      title: 'GridView',
      builder: (_) => const GridViewScreen(),
    ),
    ComponentItem(
      id: 'scrollview',
      title: 'ScrollView',
      builder: (_) => const ScrollViewScreen(),
    ),
    ComponentItem(
      id: 'aligned_gridview',
      title: 'Aligned GridView',
      builder: (_) => const AlignedGridViewScreen(),
    ),
  ],
  ComponentCategory.layout: [
    ComponentItem(
      id: 'screen_base',
      title: 'Screen Base',
      builder: (_) => const ScreenBaseScreen(),
    ),
    ComponentItem(
      id: 'app_layout',
      title: 'App Layout',
      builder: (_) => const AppLayoutScreen(),
    ),
    ComponentItem(
      id: 'grid_staggered',
      title: 'Staggered Grid',
      builder: (_) => const GridStaggeredScreen(),
    ),
    ComponentItem(
      id: 'size',
      title: 'Widget Size',
      builder: (_) => const SizeScreen(),
    ),
    ComponentItem(
      id: 'painter',
      title: 'Painter',
      builder: (_) => const PainterScreen(),
    ),
  ],
};
