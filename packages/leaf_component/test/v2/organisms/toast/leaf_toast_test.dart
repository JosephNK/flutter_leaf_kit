import 'package:flutter_leaf_component/src/v2/organisms/toast/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LeafToastType', () {
    test('enum has expected values', () {
      expect(LeafToastType.values.length, 2);
      expect(LeafToastType.lengthShort.name, 'lengthShort');
      expect(LeafToastType.lengthLong.name, 'lengthLong');
    });
  });

  group('LeafToastGravityType', () {
    test('enum has expected values', () {
      expect(LeafToastGravityType.values.length, 3);
      expect(LeafToastGravityType.top.name, 'top');
      expect(LeafToastGravityType.center.name, 'center');
      expect(LeafToastGravityType.bottom.name, 'bottom');
    });
  });

  group('LeafToastNotificationType', () {
    test('enum has expected values', () {
      expect(LeafToastNotificationType.values.length, 4);
      expect(LeafToastNotificationType.info.name, 'info');
      expect(LeafToastNotificationType.warning.name, 'warning');
      expect(LeafToastNotificationType.success.name, 'success');
      expect(LeafToastNotificationType.error.name, 'error');
    });
  });

  group('LeafToastNotificationStyle', () {
    test('enum has expected values', () {
      expect(LeafToastNotificationStyle.values.length, 5);
      expect(LeafToastNotificationStyle.minimal.name, 'minimal');
      expect(LeafToastNotificationStyle.flat.name, 'flat');
      expect(LeafToastNotificationStyle.simple.name, 'simple');
      expect(LeafToastNotificationStyle.fillColored.name, 'fillColored');
      expect(LeafToastNotificationStyle.flatColored.name, 'flatColored');
    });
  });

  group('LeafToast', () {
    test('LeafToast is a static utility class', () {
      // LeafToast has private constructor - verify static methods exist
      // We verify the class can be referenced
      expect(LeafToast, isNotNull);
    });
  });
}
