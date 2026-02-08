import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafPushNotification', () {
    testWidgets('shows notification overlay with title and body', (
      tester,
    ) async {
      late BuildContext savedContext;

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              savedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final notification = LeafPushNotification(
        title: 'Test Notification',
        body: 'Test body text',
      );

      notification.show(savedContext);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Test Notification'), findsOneWidget);
      expect(find.text('Test body text'), findsOneWidget);

      notification.closeOverlay();
    });

    testWidgets('shows notification without body', (tester) async {
      late BuildContext savedContext;

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              savedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final notification = LeafPushNotification(title: 'Title Only');

      notification.show(savedContext);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Title Only'), findsOneWidget);

      notification.closeOverlay();
    });

    testWidgets('calls onTap with data when tapped', (tester) async {
      late BuildContext savedContext;
      Map<String, dynamic>? tappedData;

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              savedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final notification = LeafPushNotification(
        title: 'Tap Me',
        data: {'id': '123'},
        onTap: (data) => tappedData = data,
      );

      notification.show(savedContext);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      expect(tappedData, {'id': '123'});
    });

    testWidgets('uses theme notification style', (tester) async {
      late BuildContext savedContext;

      final theme = LeafThemeData.light().copyWith(
        notificationTheme: const LeafNotificationThemeData(
          titleTextStyle: TextStyle(
            color: Colors.red,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              savedContext = context;
              return const SizedBox.shrink();
            },
          ),
          theme: theme,
        ),
      );

      final notification = LeafPushNotification(title: 'Themed');

      notification.show(savedContext);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Themed'), findsOneWidget);

      notification.closeOverlay();
    });

    testWidgets('has semantics label', (tester) async {
      late BuildContext savedContext;

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              savedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final notification = LeafPushNotification(title: 'Alert');

      notification.show(savedContext);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
      final hasLabel = semantics.any(
        (s) => s.properties.label == 'Notification: Alert',
      );
      expect(hasLabel, isTrue);

      notification.closeOverlay();
    });
  });
}
