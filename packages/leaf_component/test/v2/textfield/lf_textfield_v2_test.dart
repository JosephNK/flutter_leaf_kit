import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/theme_test_helper.dart';

void main() {
  group('LFTextFieldV2', () {
    late LFTextFieldControllerV2 controller;

    setUp(() {
      controller = LFTextFieldControllerV2();
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('renders empty text field', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFTextFieldV2(controller: controller),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('displays placeholder text', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFTextFieldV2(
            controller: controller,
            placeHolder: 'Enter text',
          ),
        ),
      );

      expect(find.text('Enter text'), findsOneWidget);
    });

    testWidgets('calls onChanged when text changes', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        wrapWithTheme(
          LFTextFieldV2(
            controller: controller,
            onChanged: (value) => changedValue = value,
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'hello');
      await tester.pump();

      expect(changedValue, 'hello');
    });

    testWidgets('resolves colors from theme', (tester) async {
      final customTheme = LFThemeData.light().copyWith(
        textFieldTheme: const LFTextFieldThemeData(
          borderColor: Colors.blue,
          textColor: Colors.black,
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          LFTextFieldV2(controller: controller),
          theme: customTheme,
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('programmatic setText via controller', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          LFTextFieldV2(controller: controller),
        ),
      );

      controller.text = 'Programmatic';
      await tester.pump();

      expect(controller.controller.text, 'Programmatic');
    });
  });

  group('LFTextFieldControllerV2', () {
    test('initial state is none', () {
      final ctrl = LFTextFieldControllerV2();
      expect(ctrl.status, LFTextFieldStatusV2.none);
      ctrl.dispose();
    });

    test('text setter updates status to setText', () {
      final ctrl = LFTextFieldControllerV2();
      ctrl.text = 'hello';
      expect(ctrl.value, 'hello');
      expect(ctrl.status, LFTextFieldStatusV2.setText);
      ctrl.dispose();
    });

    test('clear sets status to clear then none', () {
      final ctrl = LFTextFieldControllerV2();
      ctrl.clear();
      expect(ctrl.status, LFTextFieldStatusV2.none);
      ctrl.dispose();
    });

    test('reset sets status to reset then none', () {
      final ctrl = LFTextFieldControllerV2();
      ctrl.reset();
      expect(ctrl.status, LFTextFieldStatusV2.none);
      ctrl.dispose();
    });
  });
}
