part of '../photo.dart';

///
/// Mixin
///
mixin LFPhotoAlbumRequest {
  Future<List<AssetPathEntity>> requestAssetPaths(RequestType type) async {
    final result = await PhotoManager.requestPermissionExtend();
    if (result == PermissionState.authorized) {
      final paths = await PhotoManager.getAssetPathList(
        type: type,
        filterOption: FilterOptionGroup(
          containsPathModified: true,
          containsLivePhotos: false,
        ),
      );
      return paths;
    } else {
      await PhotoManager.openSetting();
    }
    return [];
  }
}
