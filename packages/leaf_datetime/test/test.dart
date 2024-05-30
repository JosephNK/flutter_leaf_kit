import 'package:flutter_leaf_datetime/leaf_datetime.dart';
import 'package:test/test.dart';

void main() {
  test('Test', () async {
    LFDate.parseFromString('2021-05-25T12:00:00.000Z');
    // print(LFDate.parseFromString('2021-05-25T12:00:00.000Z')
    //     .format('yyyy-MM-dd HH:mm'));
  });
}
