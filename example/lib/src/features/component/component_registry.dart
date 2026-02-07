import '../../common/models/component_category.dart';
import '../../common/models/component_item.dart';

// Atoms
import 'screens/atoms/animated_screen.dart';
import 'screens/atoms/badge_screen.dart';
import 'screens/atoms/button_screen.dart';
import 'screens/atoms/checkbox_screen.dart';
import 'screens/atoms/chip_screen.dart';
import 'screens/atoms/icon_screen.dart';
import 'screens/atoms/image_screen.dart';
import 'screens/atoms/indicator_screen.dart';
import 'screens/atoms/painter_screen.dart';
import 'screens/atoms/radio_screen.dart';
import 'screens/atoms/size_screen.dart';
import 'screens/atoms/skeleton_screen.dart';
import 'screens/atoms/slider_screen.dart';
import 'screens/atoms/switch_screen.dart';
import 'screens/atoms/text_screen.dart';

// Molecules
import 'screens/molecules/appbar_screen.dart';
import 'screens/molecules/ratingbar_screen.dart';
import 'screens/molecules/tabs_screen.dart';
import 'screens/molecules/textfield_screen.dart';

// Organisms
import 'screens/organisms/accordion_screen.dart';
import 'screens/organisms/aligned_gridview_screen.dart';
import 'screens/organisms/bottomsheet_screen.dart';
import 'screens/organisms/calendar_screen.dart';
import 'screens/organisms/dialog_screen.dart';
import 'screens/organisms/grid_staggered_screen.dart';
import 'screens/organisms/gridview_screen.dart';
import 'screens/organisms/listview_screen.dart';
import 'screens/organisms/notification_screen.dart';
import 'screens/organisms/page_screen.dart';
import 'screens/organisms/picker_screen.dart';
import 'screens/organisms/scrollview_screen.dart';
import 'screens/organisms/toast_screen.dart';

// Templates
import 'screens/templates/app_layout_screen.dart';
import 'screens/templates/navigationbar_screen.dart';
import 'screens/templates/popscope_screen.dart';
import 'screens/templates/screen_base_screen.dart';

final Map<ComponentCategory, List<ComponentItem>> componentRegistry = {
  ComponentCategory.atoms: [
    ComponentItem(
      id: 'text',
      title: 'Text',
      builder: (_) => const TextScreen(),
    ),
    ComponentItem(
      id: 'icon',
      title: 'Icon',
      builder: (_) => const IconScreen(),
    ),
    ComponentItem(
      id: 'badge',
      title: 'Badge',
      builder: (_) => const BadgeScreen(),
    ),
    ComponentItem(
      id: 'button',
      title: 'Button',
      builder: (_) => const ButtonScreen(),
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
      id: 'slider',
      title: 'Slider',
      builder: (_) => const SliderScreen(),
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
    ComponentItem(
      id: 'animated',
      title: 'Animated',
      builder: (_) => const AnimatedScreen(),
    ),
    ComponentItem(
      id: 'image',
      title: 'Image',
      builder: (_) => const ImageScreen(),
    ),
    ComponentItem(
      id: 'painter',
      title: 'Painter',
      builder: (_) => const PainterScreen(),
    ),
    ComponentItem(
      id: 'size',
      title: 'Widget Size',
      builder: (_) => const SizeScreen(),
    ),
  ],
  ComponentCategory.molecules: [
    ComponentItem(
      id: 'textfield',
      title: 'TextField',
      builder: (_) => const TextFieldScreen(),
    ),
    ComponentItem(
      id: 'ratingbar',
      title: 'Rating Bar',
      builder: (_) => const RatingBarScreen(),
    ),
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
  ],
  ComponentCategory.organisms: [
    ComponentItem(
      id: 'accordion',
      title: 'Accordion',
      builder: (_) => const AccordionScreen(),
    ),
    ComponentItem(
      id: 'dialog',
      title: 'Dialog',
      builder: (_) => const DialogScreen(),
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
    ComponentItem(
      id: 'calendar',
      title: 'Calendar',
      builder: (_) => const CalendarScreen(),
    ),
    ComponentItem(
      id: 'page',
      title: 'PageView',
      builder: (_) => const PageScreen(),
    ),
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
    ComponentItem(
      id: 'picker',
      title: 'Picker',
      builder: (_) => const PickerScreen(),
    ),
    ComponentItem(
      id: 'grid_staggered',
      title: 'Staggered Grid',
      builder: (_) => const GridStaggeredScreen(),
    ),
  ],
  ComponentCategory.templates: [
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
};
