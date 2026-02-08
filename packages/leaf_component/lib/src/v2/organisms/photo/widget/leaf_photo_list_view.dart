import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../cache/leaf_image_lru_cache.dart';

/// Callback fired when the selection changes.
typedef LeafPhotoSelectionChanged =
    void Function(List<AssetEntity> selectedEntities);

/// Callback fired when the selection limit is exceeded.
typedef LeafPhotoLimitError = void Function(Exception error, int limit);

/// A paginated photo grid that displays thumbnails from an [AssetPathEntity].
///
/// Supports single/multi-selection with a configurable limit.
/// Uses [LeafImageLruCache] for thumbnail caching.
class LeafPhotoListView extends StatefulWidget {
  final AssetPathEntity? assetPath;
  final int selectionLimit;
  final EdgeInsets padding;
  final List<AssetEntity> initialSelection;
  final Widget? checkedIcon;
  final Widget? uncheckedIcon;
  final Color? selectedBorderColor;
  final int crossAxisCount;
  final double spacing;
  final LeafPhotoSelectionChanged? onSelectionChanged;
  final LeafPhotoLimitError? onLimitError;

  const LeafPhotoListView({
    super.key,
    required this.assetPath,
    this.selectionLimit = 3,
    this.padding = EdgeInsets.zero,
    this.initialSelection = const [],
    this.checkedIcon,
    this.uncheckedIcon,
    this.selectedBorderColor,
    this.crossAxisCount = 3,
    this.spacing = 3.0,
    this.onSelectionChanged,
    this.onLimitError,
  });

  @override
  State<LeafPhotoListView> createState() => _LeafPhotoListViewState();
}

class _LeafPhotoListViewState extends State<LeafPhotoListView> {
  static const _pageSize = 50;

  List<AssetEntity> _entities = [];
  List<AssetEntity> _selectedEntities = [];
  int _totalCount = 0;
  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    LeafImageLruCache.clearCache();
    _selectedEntities = List.of(widget.initialSelection);

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAssets();
    });
  }

  @override
  void didUpdateWidget(covariant LeafPhotoListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      _resetAndLoad();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.offset;
    final max = _scrollController.position.maxScrollExtent;
    if (pos >= max && !_isLoadingMore && _hasMore) {
      _loadMore();
    }
  }

  Future<void> _resetAndLoad() async {
    _page = 0;
    _entities = [];
    _hasMore = true;
    await _loadAssets();
  }

  Future<void> _loadAssets() async {
    if (!mounted || _isLoading || widget.assetPath == null) return;

    setState(() => _isLoading = true);

    _totalCount = await widget.assetPath!.assetCountAsync;
    final entities = await widget.assetPath!.getAssetListPaged(
      page: 0,
      size: _pageSize,
    );

    if (!mounted) return;
    setState(() {
      _entities = entities;
      _isLoading = false;
      _hasMore = _entities.length < _totalCount;
    });
  }

  Future<void> _loadMore() async {
    if (!mounted || _isLoadingMore || widget.assetPath == null) return;

    setState(() => _isLoadingMore = true);

    final entities = await widget.assetPath!.getAssetListPaged(
      page: _page + 1,
      size: _pageSize,
    );

    if (!mounted) return;
    setState(() {
      _entities = [..._entities, ...entities];
      _page++;
      _hasMore = _entities.length < _totalCount;
      _isLoadingMore = false;
    });
  }

  void _onItemTap(AssetEntity entity) {
    final isSelected = _selectedEntities.contains(entity);

    List<AssetEntity> newSelection;
    if (widget.selectionLimit == 1) {
      newSelection = isSelected ? [] : [entity];
    } else {
      newSelection = List.of(_selectedEntities);
      if (isSelected) {
        newSelection.remove(entity);
      } else {
        if (newSelection.length >= widget.selectionLimit) {
          widget.onLimitError?.call(
            Exception('Selection limit of ${widget.selectionLimit} exceeded.'),
            widget.selectionLimit,
          );
          return;
        }
        newSelection.add(entity);
      }
    }

    setState(() => _selectedEntities = newSelection);
    widget.onSelectionChanged?.call(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Photo grid',
      child: Padding(
        padding: widget.padding,
        child: GridView.builder(
          itemCount: _entities.length,
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            crossAxisSpacing: widget.spacing,
            mainAxisSpacing: widget.spacing,
          ),
          itemBuilder: (context, index) {
            final entity = _entities[index];
            final checked = _selectedEntities.contains(entity);
            return _PhotoGridItem(
              entity: entity,
              checked: checked,
              checkedIcon: widget.checkedIcon,
              uncheckedIcon: widget.uncheckedIcon,
              selectedBorderColor: widget.selectedBorderColor,
              onTap: () => _onItemTap(entity),
            );
          },
        ),
      ),
    );
  }
}

/// A single grid item that shows a thumbnail with selection state.
class _PhotoGridItem extends StatelessWidget {
  final AssetEntity entity;
  final bool checked;
  final Widget? checkedIcon;
  final Widget? uncheckedIcon;
  final Color? selectedBorderColor;
  final VoidCallback onTap;

  const _PhotoGridItem({
    required this.entity,
    required this.checked,
    this.checkedIcon,
    this.uncheckedIcon,
    this.selectedBorderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Stack(
        children: [
          _PhotoThumbnail(entity: entity),
          _SelectionOverlay(checked: checked, borderColor: selectedBorderColor),
          Positioned(
            top: 0,
            right: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
              child: checked
                  ? (checkedIcon ??
                        const Icon(Icons.check_box, color: Colors.blueAccent))
                  : (uncheckedIcon ??
                        Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.grey.withValues(alpha: 0.8),
                        )),
            ),
          ),
          if (entity.type == AssetType.video)
            Positioned(
              bottom: 5.0,
              right: 5.0,
              child: Text(
                entity.videoDuration
                    .toString()
                    .split('.')
                    .first
                    .padLeft(8, '0'),
                style: const TextStyle(fontSize: 12.0, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

/// Renders an [AssetEntity] thumbnail with LRU caching.
class _PhotoThumbnail extends StatelessWidget {
  static const _cacheSize = 64;

  final AssetEntity entity;

  const _PhotoThumbnail({required this.entity});

  @override
  Widget build(BuildContext context) {
    final cached = LeafImageLruCache.getData(entity, _cacheSize);
    if (cached != null) {
      return _buildImage(cached);
    }

    return FutureBuilder<Uint8List?>(
      future: entity.thumbnailDataWithOption(
        const ThumbnailOption(size: ThumbnailSize.square(150), quality: 100),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          LeafImageLruCache.setData(entity, _cacheSize, snapshot.data!);
          return _buildImage(snapshot.data!);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildImage(Uint8List data) {
    return Image.memory(
      data,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

/// Selection border overlay.
class _SelectionOverlay extends StatelessWidget {
  final bool checked;
  final Color? borderColor;

  const _SelectionOverlay({required this.checked, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: checked
            ? BoxDecoration(
                border: Border.all(
                  color: borderColor ?? Colors.blueAccent,
                  width: 3,
                ),
              )
            : const BoxDecoration(),
      ),
    );
  }
}
