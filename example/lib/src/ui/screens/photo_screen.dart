import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class PhotoScreen extends ScreenStatefulWidget {
  final String title;

  const PhotoScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends ScreenState<PhotoScreen> {
  AssetPathEntity? _selectedAssetPath;
  List<AssetEntity> _selectedEntities = [];

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(
      // centerTitle: true,
      title: LFPhotoAlbumSheetTitleView(
        type: RequestType.all,
        selectedAssetPath: _selectedAssetPath,
        onSelected: (assetPath) {
          setState(() {
            _selectedAssetPath = assetPath;
          });
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: LFPhotoListView(
            selectedLimit: 5,
            selectedAssetPath: _selectedAssetPath,
            selectedEntities: _selectedEntities,
            onSelected: (entities) {
              setState(() {
                _selectedEntities = entities;
              });
            },
            onLimitError: (e, limit) {
              Logging.d('Limit error: $e, $limit');
              LFAlertDialog.show(context, message: e.toString());
            },
          ),
        ),
      ],
    );
  }
}
