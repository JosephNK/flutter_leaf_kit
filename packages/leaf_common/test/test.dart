import 'package:flutter/material.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Uri appendPath', () async {
    try {
      final uri1 = Uri.parse('https://www.naver.com').appendPath('/path?a=123');
      debugPrint('[R] uri: $uri1');
      final uri2 = Uri.parse('https://www.naver.com')
          .appendPath('https://www.google.com/path?a=123');
      debugPrint('[R] uri: $uri2');
      final uri3 = Uri.parse('https://www.naver.com')
          .appendPath('wss://www.google.com/path?a=123');
      debugPrint('[R] uri: $uri3');
    } catch (e) {
      debugPrint('[R] errorException: $e');
    }
  });
}
