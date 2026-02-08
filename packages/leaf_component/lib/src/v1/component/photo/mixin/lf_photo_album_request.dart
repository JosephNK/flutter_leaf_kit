part of '../photo.dart';

///
/// Mixin
///
@Deprecated('V1 component deprecated. Use V2 components instead.')
mixin LFPhotoAlbumRequest {
  Future<List<AssetPathEntity>> requestAssetPaths(RequestType type) async {
    final result = await PhotoManager.requestPermissionExtend();
    if (result == PermissionState.authorized) {
      final paths = await PhotoManager.getAssetPathList(
        type: type,
        filterOption: FilterOptionGroup(containsPathModified: true),
      );
      return paths;
    } else {
      await PhotoManager.openSetting();
    }
    return [];
  }
}
