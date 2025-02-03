// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example/src/models/person.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // // Build our app and trigger a frame.
    // await tester.pumpWidget(const MyApp());
    //
    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });

  test('Test UIModel', () {
    const person1 = Person(
      payload: '1',
      name: 'John Doe',
      age: 30,
    );
    final person1Payload = person1.getPayload<String>();

    const person2 = Person(
      payload: '1',
      name: 'John Doe',
      age: 30,
    );
    final person2Payload = person2.getPayload<String>();

    debugPrint('person1: $person1, payload: $person1Payload');
    debugPrint('person2: $person2, payload: $person2Payload');

    expect(person1 == person2, true);
  });

  test('Test UIModelV2', () {
    const person1 = PersonV2(
      payload: '1',
      name: 'John Doe',
      age: 30,
    );
    final person1Payload = person1.getPayload();

    const person2 = PersonV2(
      payload: '1',
      name: 'John Doe',
      age: 30,
    );
    final person2Payload = person2.getPayload();

    debugPrint('person1: $person1, payload: $person1Payload');
    debugPrint('person2: $person2, payload: $person2Payload');

    expect(person1 == person2, true);
  });
}
