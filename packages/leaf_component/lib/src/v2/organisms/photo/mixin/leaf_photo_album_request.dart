import 'package:photo_manager/photo_manager.dart';

/// Mixin that provides photo album asset loading via `photo_manager`.
///
/// Usage:
/// ```dart
/// class _MyState extends State<MyWidget> with LeafPhotoAlbumRequest {
///   Future<void> _load() async {
///     final paths = await requestAssetPaths(RequestType.image);
///   }
/// }
/// ```
mixin LeafPhotoAlbumRequest {
  /// Requests the list of asset paths (albums) for the given [type].
  ///
  /// Returns an empty list if the user denies permission.
  /// If permission is not granted, opens the system settings page.
  Future<List<AssetPathEntity>> requestAssetPaths(RequestType type) async {
    final result = await PhotoManager.requestPermissionExtend();
    if (result == PermissionState.authorized ||
        result == PermissionState.limited) {
      final paths = await PhotoManager.getAssetPathList(
        type: type,
        filterOption: FilterOptionGroup(containsPathModified: true),
      );
      return paths;
    }
    await PhotoManager.openSetting();
    return [];
  }
}
