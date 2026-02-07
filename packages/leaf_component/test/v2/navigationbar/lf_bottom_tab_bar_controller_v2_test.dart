import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/src/v2/component/navigationbar/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LFBottomTabBarControllerV2', () {
    late LFBottomTabBarControllerV2 controller;
    late List<LFBottomTabItemV2> items;

    setUp(() {
      controller = LFBottomTabBarControllerV2();
      items = List.generate(
        3,
        (i) => LFBottomTabItemV2(
          tabIndex: LFBottomTabIndexV2(tabIndex: i),
          defaultIcon: Icon(Icons.home, key: ValueKey('icon_$i')),
          label: 'Tab $i',
        ),
      );
    });

    tearDown(() {
      controller.dispose();
    });

    test('initial state has default values', () {
      expect(controller.selectedIndex, 0);
      expect(controller.previousIndex, 0);
      expect(controller.tabItems, isEmpty);
    });

    test('setItems initialises items and selection', () {
      controller.setItems(items, selectedIndex: 1);

      expect(controller.tabItems.length, 3);
      expect(controller.selectedIndex, 1);
      expect(controller.tabItems[1].tabIndex.isSelected, isTrue);
      expect(controller.tabItems[0].tabIndex.isSelected, isFalse);
    });

    test('selectedIndex setter updates state and notifies', () {
      controller.setItems(items, selectedIndex: 0);
      int notifyCount = 0;
      controller.addListener(() => notifyCount++);

      controller.selectedIndex = 2;

      expect(controller.selectedIndex, 2);
      expect(controller.previousIndex, 0);
      expect(controller.tabItems[2].tabIndex.isSelected, isTrue);
      expect(controller.tabItems[0].tabIndex.isSelected, isFalse);
      expect(notifyCount, 1);
    });

    test('selectedIndex ignores out of range values', () {
      controller.setItems(items, selectedIndex: 0);
      int notifyCount = 0;
      controller.addListener(() => notifyCount++);

      controller.selectedIndex = -1;
      expect(controller.selectedIndex, 0);
      expect(notifyCount, 0);

      controller.selectedIndex = 5;
      expect(controller.selectedIndex, 0);
      expect(notifyCount, 0);
    });

    test('updateBadge updates badge count for specific tab', () {
      controller.setItems(items, selectedIndex: 0);
      int notifyCount = 0;
      controller.addListener(() => notifyCount++);

      controller.updateBadge(tabIndex: 1, badgeCount: 5);

      expect(controller.tabItems[1].badgeCount, 5);
      expect(controller.tabItems[0].badgeCount, 0);
      expect(notifyCount, 1);
    });

    test('custom initialIndex is applied', () {
      final customController = LFBottomTabBarControllerV2(initialIndex: 2);
      expect(customController.selectedIndex, 2);
      customController.dispose();
    });
  });
}
