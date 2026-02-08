import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/theme_test_helper.dart';

void main() {
  group('LeafAlertDialog', () {
    testWidgets('show() displays message and OK button', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafAlertDialog.show(context, message: 'Test message');
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Test message'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('show() displays title when provided', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafAlertDialog.show(
                    context,
                    title: 'Test Title',
                    message: 'Test message',
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test message'), findsOneWidget);
    });

    testWidgets('confirm() displays Cancel and OK buttons', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafAlertDialog.confirm(
                    context,
                    title: 'Confirm',
                    message: 'Are you sure?',
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('show() with close button displays close icon', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafAlertDialog.show(
                    context,
                    title: 'Title',
                    message: 'Msg',
                    visibleCloseButton: true,
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('show() with custom ok text uses provided text', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafAlertDialog.show(
                    context,
                    message: 'Msg',
                    okText: 'Got it',
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Got it'), findsOneWidget);
    });

    testWidgets('confirm() with custom button texts', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafAlertDialog.confirm(
                    context,
                    message: 'Msg',
                    okText: 'Yes',
                    cancelText: 'No',
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Yes'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);
    });
  });

  group('LeafDialogTitle', () {
    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafDialogTitle(text: 'Dialog Title')),
      );

      expect(find.text('Dialog Title'), findsOneWidget);
    });
  });

  group('LeafDialogMessage', () {
    testWidgets('renders message text', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(const LeafDialogMessage(text: 'Dialog Message')),
      );

      expect(find.text('Dialog Message'), findsOneWidget);
    });
  });

  group('LeafDialogButton', () {
    testWidgets('OK button renders with default text', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafDialogOKButton()));

      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('Cancel button renders with default text', (tester) async {
      await tester.pumpWidget(wrapWithTheme(const LeafDialogCancelButton()));

      expect(find.text('Cancel'), findsOneWidget);
    });
  });

  group('LeafRadioPickerDialog', () {
    testWidgets('displays items and title', (tester) async {
      final items = [
        const LeafDataItem(id: '1', text: 'Option A'),
        const LeafDataItem(id: '2', text: 'Option B'),
      ];

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafRadioPickerDialog.show(
                    context,
                    items: items,
                    value: items.first,
                    title: 'Pick one',
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Pick one'), findsOneWidget);
      expect(find.text('Option A'), findsOneWidget);
      expect(find.text('Option B'), findsOneWidget);
    });
  });

  group('LeafCheckboxPickerDialog', () {
    testWidgets('displays items and title', (tester) async {
      final items = [
        const LeafDataItem(id: '1', text: 'Check A'),
        const LeafDataItem(id: '2', text: 'Check B'),
      ];

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafCheckboxPickerDialog.show(
                    context,
                    items: items,
                    title: 'Select items',
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Select items'), findsOneWidget);
      expect(find.text('Check A'), findsOneWidget);
      expect(find.text('Check B'), findsOneWidget);
    });
  });

  group('LeafChipPickerDialog', () {
    testWidgets('displays items and title', (tester) async {
      final items = [
        const LeafDataItem(id: '1', text: 'Chip A'),
        const LeafDataItem(id: '2', text: 'Chip B'),
      ];

      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafChipPickerDialog.show(
                    context,
                    items: items,
                    title: 'Pick chips',
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Pick chips'), findsOneWidget);
      expect(find.text('Chip A'), findsOneWidget);
      expect(find.text('Chip B'), findsOneWidget);
    });
  });

  group('LeafCalendarDatePickerDialog', () {
    testWidgets('displays calendar and OK button', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafCalendarDatePickerDialog.show(
                    context,
                    date: DateTime(2025, 6, 15),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsOneWidget);
      // CalendarDatePicker renders day numbers
      expect(find.text('15'), findsWidgets);
    });
  });

  group('LeafCalendarTimePickerDialog', () {
    testWidgets('displays time picker and OK button', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafCalendarTimePickerDialog.show(
                    context,
                    time: DateTime(2025, 1, 1, 14, 30),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsOneWidget);
      // CupertinoDatePicker renders itself
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
    });
  });

  group('LeafCalendarBetweenDatePickerDialog', () {
    testWidgets('displays start/end header and calendar', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafCalendarBetweenDatePickerDialog.show(
                    context,
                    pickerSelect: LeafCalendarBetweenPickerSelect.start,
                    startDate: DateTime(2025, 6, 1),
                    endDate: DateTime(2025, 6, 30),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Start'), findsOneWidget);
      expect(find.text('End'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });
  });

  group('LeafCalendarBetweenTimePickerDialog', () {
    testWidgets('displays start/end header and time picker', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  LeafCalendarBetweenTimePickerDialog.show(
                    context,
                    pickerSelect: LeafCalendarBetweenPickerSelect.start,
                    startTime: DateTime(2025, 1, 1, 9, 0),
                    endTime: DateTime(2025, 1, 1, 17, 0),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Start'), findsOneWidget);
      expect(find.text('End'), findsOneWidget);
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
    });
  });
}
