import 'dart:collection';
import 'dart:typed_data';

import 'package:photo_manager/photo_manager.dart';

/// LRU (Least Recently Used) image cache for [AssetEntity] thumbnails.
///
/// Stores thumbnail [Uint8List] data keyed by entity + requested size.
/// When the cache exceeds [maxSize], the least-recently-used entry is evicted.
class LeafImageLruCache {
  static final _LRUMapV2<_ImageCacheKey, Uint8List> _map = _LRUMapV2(500);

  /// Returns cached thumbnail data, or `null` if not found.
  static Uint8List? getData(AssetEntity entity, [int size = 64]) {
    return _map.get(_ImageCacheKey(entity, size));
  }

  /// Stores thumbnail data in the cache.
  static void setData(AssetEntity entity, int size, Uint8List data) {
    _map.put(_ImageCacheKey(entity, size), data);
  }

  /// Clears all cached entries.
  static void clearCache() {
    _map.clear();
  }

  /// Returns the current number of cached entries.
  static int get length => _map.length;
}

/// Composite key for the image cache.
class _ImageCacheKey {
  final AssetEntity entity;
  final int size;

  const _ImageCacheKey(this.entity, this.size);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ImageCacheKey &&
          runtimeType == other.runtimeType &&
          entity == other.entity &&
          size == other.size;

  @override
  int get hashCode => entity.hashCode ^ size.hashCode;
}

/// Generic LRU map implementation.
class _LRUMapV2<K, V> {
  final LinkedHashMap<K, V> _map = LinkedHashMap<K, V>();
  final int _maxSize;

  _LRUMapV2(this._maxSize);

  int get length => _map.length;

  V? get(K key) {
    final value = _map.remove(key);
    if (value != null) {
      _map[key] = value;
    }
    return value;
  }

  void put(K key, V value) {
    _map.remove(key);
    _map[key] = value;
    if (_map.length > _maxSize) {
      final evictedKey = _map.keys.first;
      _map.remove(evictedKey);
    }
  }

  void remove(K key) {
    _map.remove(key);
  }

  void clear() {
    _map.clear();
  }
}
