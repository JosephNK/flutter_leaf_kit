part of leaf_picker_component;

class LeafImagePicker {
  static Future<List<wechat.AssetEntity>> showPhotos(
    BuildContext context, {
    required bool mounted,
    int maxImages = 5,
  }) async {
    var resultList = <wechat.AssetEntity>[];
    try {
      final assets = await wechat.AssetPicker.pickAssets(
        context,
        pickerConfig: wechat.AssetPickerConfig(
          maxAssets: maxImages,
          requestType: wechat.RequestType.image,
          textDelegate: KoreanTextDelegate(),
        ),
      );
      if (assets != null) {
        resultList.addAll(assets);
      }
    } on Exception catch (_) {
      // error = e.toString();
    }
    if (!mounted) return [];
    return resultList;
  }

  static Future<List<XFile>> showCamera({
    required bool mounted,
    required int imageQuality,
  }) async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (!mounted) return [];
    if (pickedFile != null) {
      return [pickedFile];
    }
    return [];
  }
}

////////////////////////////////////////////////////////////////////////////////

class KoreanTextDelegate extends wechat.AssetPickerTextDelegate {
  KoreanTextDelegate();

  @override
  String confirm = '확인';

  @override
  String cancel = '취소';

  @override
  String edit = '수정';

  @override
  String gifIndicator = 'GIF';

  @override
  String loadFailed = 'Load failed';

  @override
  String original = 'Origin';

  @override
  String preview = 'Preview';

  @override
  String select = '선택';

  @override
  String get emptyList => 'Empty list';

  @override
  String get unSupportedAssetType => 'Unsupported HEIC asset type.';

  @override
  String get unableToAccessAll => 'Unable to access all assets on the device';

  @override
  String get viewingLimitedAssetsTip =>
      'Only view assets and albums accessible to app.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Update limited access assets list';

  @override
  String get accessAllTip => 'App can only access some assets on the device. '
      'Go to system settings and allow app to access all assets on the device.';

  @override
  String get goToSystemSettings => 'Go to system settings';

  @override
  String get accessLimitedAssets => 'Continue with limited access';

  @override
  String get accessiblePathName => 'Accessible assets';

  @override
  String durationIndicatorBuilder(Duration duration) {
    const separator = ':';
    final minute = duration.inMinutes.toString().padLeft(2, '0');
    final second =
        ((duration - Duration(minutes: duration.inMinutes)).inSeconds)
            .toString()
            .padLeft(2, '0');
    return '$minute$separator$second';
  }
}
