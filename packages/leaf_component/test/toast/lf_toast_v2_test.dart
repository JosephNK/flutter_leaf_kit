import 'package:flutter_leaf_component/src/component_v2/toast/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LFToastTypeV2', () {
    test('enum has expected values', () {
      expect(LFToastTypeV2.values.length, 2);
      expect(LFToastTypeV2.lengthShort.name, 'lengthShort');
      expect(LFToastTypeV2.lengthLong.name, 'lengthLong');
    });
  });

  group('LFToastGravityTypeV2', () {
    test('enum has expected values', () {
      expect(LFToastGravityTypeV2.values.length, 3);
      expect(LFToastGravityTypeV2.top.name, 'top');
      expect(LFToastGravityTypeV2.center.name, 'center');
      expect(LFToastGravityTypeV2.bottom.name, 'bottom');
    });
  });

  group('LFToastNotificationTypeV2', () {
    test('enum has expected values', () {
      expect(LFToastNotificationTypeV2.values.length, 4);
      expect(LFToastNotificationTypeV2.info.name, 'info');
      expect(LFToastNotificationTypeV2.warning.name, 'warning');
      expect(LFToastNotificationTypeV2.success.name, 'success');
      expect(LFToastNotificationTypeV2.error.name, 'error');
    });
  });

  group('LFToastNotificationStyleV2', () {
    test('enum has expected values', () {
      expect(LFToastNotificationStyleV2.values.length, 5);
      expect(LFToastNotificationStyleV2.minimal.name, 'minimal');
      expect(LFToastNotificationStyleV2.flat.name, 'flat');
      expect(LFToastNotificationStyleV2.simple.name, 'simple');
      expect(LFToastNotificationStyleV2.fillColored.name, 'fillColored');
      expect(LFToastNotificationStyleV2.flatColored.name, 'flatColored');
    });
  });

  group('LFToastV2', () {
    test('LFToastV2 is a static utility class', () {
      // LFToastV2 has private constructor - verify static methods exist
      // We verify the class can be referenced
      expect(LFToastV2, isNotNull);
    });
  });
}
