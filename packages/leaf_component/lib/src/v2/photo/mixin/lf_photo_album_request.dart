part of lf_photo;

///
/// Mixin
///
mixin LFPhotoAlbumRequest {
  Future<List<AssetPathEntity>> requestAssetPaths() async {
    final result = await PhotoManager.requestPermissionExtend();
    if (result == PermissionState.authorized) {
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.common,
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
