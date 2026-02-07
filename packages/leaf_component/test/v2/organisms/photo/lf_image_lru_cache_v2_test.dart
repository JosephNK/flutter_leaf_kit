import 'dart:typed_data';

import 'package:flutter_leaf_component/src/v2/organisms/photo/cache/lf_image_lru_cache_v2.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_manager/photo_manager.dart';

/// Creates a minimal [AssetEntity] for testing purposes.
AssetEntity _makeAsset(String id) {
  return AssetEntity(
    id: id,
    typeInt: AssetType.image.index,
    width: 100,
    height: 100,
  );
}

void main() {
  group('LFImageLruCacheV2', () {
    setUp(() {
      LFImageLruCacheV2.clearCache();
    });

    test('getData returns null for empty cache', () {
      final entity = _makeAsset('test-1');
      expect(LFImageLruCacheV2.getData(entity), isNull);
    });

    test('setData and getData round-trip', () {
      final entity = _makeAsset('test-2');
      final data = Uint8List.fromList([1, 2, 3, 4]);

      LFImageLruCacheV2.setData(entity, 64, data);

      final result = LFImageLruCacheV2.getData(entity, 64);
      expect(result, equals(data));
    });

    test('different sizes are stored separately', () {
      final entity = _makeAsset('test-3');
      final data64 = Uint8List.fromList([1, 2]);
      final data128 = Uint8List.fromList([3, 4, 5]);

      LFImageLruCacheV2.setData(entity, 64, data64);
      LFImageLruCacheV2.setData(entity, 128, data128);

      expect(LFImageLruCacheV2.getData(entity, 64), equals(data64));
      expect(LFImageLruCacheV2.getData(entity, 128), equals(data128));
    });

    test('clearCache removes all entries', () {
      final entity = _makeAsset('test-4');
      LFImageLruCacheV2.setData(entity, 64, Uint8List.fromList([1]));

      expect(LFImageLruCacheV2.getData(entity, 64), isNotNull);

      LFImageLruCacheV2.clearCache();

      expect(LFImageLruCacheV2.getData(entity, 64), isNull);
    });

    test('length reflects number of cached entries', () {
      expect(LFImageLruCacheV2.length, 0);

      LFImageLruCacheV2.setData(
          _makeAsset('a'), 64, Uint8List.fromList([1]));
      LFImageLruCacheV2.setData(
          _makeAsset('b'), 64, Uint8List.fromList([2]));

      expect(LFImageLruCacheV2.length, 2);
    });

    test('same entity+size overwrites without increasing length', () {
      final entity = _makeAsset('test-5');
      LFImageLruCacheV2.setData(entity, 64, Uint8List.fromList([1]));
      LFImageLruCacheV2.setData(entity, 64, Uint8List.fromList([2, 3]));

      expect(LFImageLruCacheV2.length, 1);
      expect(
        LFImageLruCacheV2.getData(entity, 64),
        equals(Uint8List.fromList([2, 3])),
      );
    });
  });
}
