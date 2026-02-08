import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test', () async {
    LeafDate.parseFromString('2021-05-25T12:00:00.000Z');
    // print(LeafDate.parseFromString('2021-05-25T12:00:00.000Z')
    //     .format('yyyy-MM-dd HH:mm'));
  });
}
