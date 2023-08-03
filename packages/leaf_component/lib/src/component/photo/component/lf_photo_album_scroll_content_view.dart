part of lf_photo;

///
/// LFPhotoAlbumScrollContentView
///
class LFPhotoAlbumScrollContentView extends StatefulWidget {
  final RequestType type;
  final AssetPathEntity? selectedAssetPath;
  final bool visible;
  final String? recentName;
  final ValueChanged<AssetPathEntity>? onSelected;

  const LFPhotoAlbumScrollContentView({
    Key? key,
    required this.type,
    required this.selectedAssetPath,
    required this.visible,
    this.recentName,
    this.onSelected,
  }) : super(key: key);

  @override
  State<LFPhotoAlbumScrollContentView> createState() =>
      _LFPhotoAlbumScrollContentViewState();
}

class _LFPhotoAlbumScrollContentViewState
    extends State<LFPhotoAlbumScrollContentView> with LFPhotoAlbumRequest {
  late LFExpandAnimationController _expandController;

  List<AssetPathEntity> _assetPathEntityList = [];
  AssetPathEntity? _selectedAssetPathEntity;

  @override
  void initState() {
    super.initState();

    _expandController = LFExpandAnimationController(
      autoAnimation: false,
      repeatCount: -1,
      duration: const Duration(milliseconds: 250),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      update();
    });
  }

  @override
  void didUpdateWidget(covariant LFPhotoAlbumScrollContentView oldWidget) {
    if (oldWidget.selectedAssetPath != widget.selectedAssetPath) {
      if (_assetPathEntityList.isEmpty) {
        update();
      }
    }
    if (oldWidget.visible != widget.visible) {
      if (widget.visible) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final visible = widget.visible;
    final recentName = widget.recentName;

    return Stack(
      fit: StackFit.expand,
      children: [
        Visibility(
          visible: visible,
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: LFExpandAnimated(
            controller: _expandController,
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Container(
                  width: constraint.maxWidth,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ..._assetPathEntityList.map((assetPathEntity) {
                          final checked = assetPathEntity.id ==
                              _selectedAssetPathEntity?.id;
                          return LFPhotoAlbumScrollContentTile(
                            assetPathEntity: assetPathEntity,
                            selectedAssetPathEntity: _selectedAssetPathEntity,
                            checked: checked,
                            recentName: recentName,
                            onSelected: (assetPathEntity) {
                              setState(() {
                                _selectedAssetPathEntity = assetPathEntity;
                              });
                              widget.onSelected?.call(assetPathEntity);
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void update() async {
    _selectedAssetPathEntity = widget.selectedAssetPath;
    final assetPathList = await requestAssetPaths(widget.type);
    setState(() {
      _assetPathEntityList = assetPathList;
    });
  }
}

///
/// LFPhotoAlbumScrollContentTile
///
class LFPhotoAlbumScrollContentTile extends StatefulWidget {
  final AssetPathEntity assetPathEntity;
  final AssetPathEntity? selectedAssetPathEntity;
  final bool checked;
  final String? recentName;
  final ValueChanged<AssetPathEntity>? onSelected;

  const LFPhotoAlbumScrollContentTile({
    Key? key,
    required this.assetPathEntity,
    required this.selectedAssetPathEntity,
    required this.checked,
    this.recentName,
    this.onSelected,
  }) : super(key: key);

  @override
  State<LFPhotoAlbumScrollContentTile> createState() =>
      _LFPhotoAlbumScrollContentTileState();
}

class _LFPhotoAlbumScrollContentTileState
    extends State<LFPhotoAlbumScrollContentTile> {
  List<AssetEntity> _entities = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final assetPathEntity = widget.assetPathEntity;
    final selectedAssetPathEntity = widget.selectedAssetPathEntity;
    final checked = widget.checked;
    final recentName = widget.recentName;
    final onSelected = widget.onSelected;

    String name = assetPathEntity.name;
    if (name == 'Recent' && recentName != null) {
      name = recentName;
    }

    final entities = _entities;
    if (entities.isEmpty) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.only(left: 12.0),
      child: Stack(
        children: [
          Column(
            children: [
              LFPhotoAlbumEntityTile(
                assetPathEntity: assetPathEntity,
                selectedAssetPathEntity: selectedAssetPathEntity,
                entity: entities.first,
                size: 72.0,
                checked: checked,
                onSelected: onSelected,
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: 72.0,
                child: LFText(
                  name,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Request Assets
  Future<void> _requestAssets() async {
    final assetPathEntity = widget.assetPathEntity;

    if (!mounted) return;
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final entities = await assetPathEntity.getAssetListPaged(
      page: 0,
      size: 1,
    );

    setState(() {
      _entities = entities;
      _isLoading = false;
    });
  }
}

///
/// LFPhotoAlbumEntityTile
///
class LFPhotoAlbumEntityTile extends StatefulWidget {
  final AssetPathEntity assetPathEntity;
  final AssetPathEntity? selectedAssetPathEntity;
  final AssetEntity entity;
  final double size;
  final bool checked;
  final ValueChanged<AssetPathEntity>? onSelected;

  const LFPhotoAlbumEntityTile({
    Key? key,
    required this.assetPathEntity,
    required this.selectedAssetPathEntity,
    required this.entity,
    required this.size,
    required this.checked,
    this.onSelected,
  }) : super(key: key);

  @override
  State<LFPhotoAlbumEntityTile> createState() => _LFPhotoAlbumEntityTileState();
}

class _LFPhotoAlbumEntityTileState extends State<LFPhotoAlbumEntityTile> {
  Uint8List? _data;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final entity = widget.entity;
      final thumbnailData = await entity.thumbnailData;
      setState(() {
        _data = thumbnailData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_data == null) return Container();
    return _buildImageItem(context, _data!);
  }

  Widget _buildImageItem(BuildContext context, Uint8List data) {
    return GestureDetector(
      onTap: () {
        widget.onSelected?.call(widget.assetPathEntity);
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.memory(
                data,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Visibility(
                visible: widget.checked,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: const Icon(Icons.check_sharp,
                      color: Colors.white, size: 35.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
