import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../cache/leaf_image_lru_cache.dart';
import '../mixin/leaf_photo_album_request.dart';

/// A photo album selector that displays available albums in a horizontal
/// scroll row and allows the user to pick one.
///
/// This widget combines the functionality of V1's scroll-content, scroll-title,
/// and sheet-title views into a single composable widget.
class LeafPhotoAlbum extends StatefulWidget {
  final RequestType type;
  final AssetPathEntity? selectedAssetPath;
  final String? recentAlbumLabel;
  final TextStyle? titleTextStyle;
  final TextStyle? albumNameStyle;
  final double albumThumbnailSize;
  final ValueChanged<AssetPathEntity>? onAlbumSelected;

  const LeafPhotoAlbum({
    super.key,
    required this.type,
    this.selectedAssetPath,
    this.recentAlbumLabel,
    this.titleTextStyle,
    this.albumNameStyle,
    this.albumThumbnailSize = 72.0,
    this.onAlbumSelected,
  });

  @override
  State<LeafPhotoAlbum> createState() => _LeafPhotoAlbumState();
}

class _LeafPhotoAlbumState extends State<LeafPhotoAlbum>
    with LeafPhotoAlbumRequest {
  List<AssetPathEntity> _albums = [];
  AssetPathEntity? _selectedAlbum;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _selectedAlbum = widget.selectedAssetPath;
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAlbums());
  }

  @override
  void didUpdateWidget(covariant LeafPhotoAlbum oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedAssetPath != widget.selectedAssetPath) {
      _selectedAlbum = widget.selectedAssetPath;
      if (_albums.isEmpty) _loadAlbums();
    }
  }

  Future<void> _loadAlbums() async {
    final albums = await requestAssetPaths(widget.type);
    if (!mounted) return;

    final selected =
        _selectedAlbum ?? (albums.isNotEmpty ? albums.first : null);

    setState(() {
      _albums = albums;
      _selectedAlbum = selected;
    });

    if (selected != null) {
      widget.onAlbumSelected?.call(selected);
    }
  }

  String _albumDisplayName(String name) {
    if (name == 'Recent' && widget.recentAlbumLabel != null) {
      return widget.recentAlbumLabel!;
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Photo album selector',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: _isExpanded ? _buildAlbumRow() : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    final albumName = _selectedAlbum != null
        ? _albumDisplayName(_selectedAlbum!.name)
        : '';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              albumName,
              style: widget.titleTextStyle ??
                  const TextStyle(fontSize: 18.0),
            ),
            Icon(
              _isExpanded
                  ? Icons.arrow_drop_up_sharp
                  : Icons.arrow_drop_down_sharp,
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumRow() {
    if (_albums.isEmpty) return const SizedBox.shrink();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ..._albums.map((album) {
              final isActive = album.id == _selectedAlbum?.id;
              return _AlbumTile(
                album: album,
                isActive: isActive,
                size: widget.albumThumbnailSize,
                displayName: _albumDisplayName(album.name),
                nameStyle: widget.albumNameStyle,
                onTap: () {
                  setState(() {
                    _selectedAlbum = album;
                    _isExpanded = false;
                  });
                  widget.onAlbumSelected?.call(album);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// A single album tile showing a thumbnail preview and name.
class _AlbumTile extends StatefulWidget {
  final AssetPathEntity album;
  final bool isActive;
  final double size;
  final String displayName;
  final TextStyle? nameStyle;
  final VoidCallback onTap;

  const _AlbumTile({
    required this.album,
    required this.isActive,
    required this.size,
    required this.displayName,
    this.nameStyle,
    required this.onTap,
  });

  @override
  State<_AlbumTile> createState() => _AlbumTileState();
}

class _AlbumTileState extends State<_AlbumTile> {
  Uint8List? _thumbnail;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadThumbnail());
  }

  Future<void> _loadThumbnail() async {
    final entities = await widget.album.getAssetListPaged(page: 0, size: 1);
    if (!mounted || entities.isEmpty) return;

    final entity = entities.first;
    final cached = LeafImageLruCache.getData(entity, widget.size.toInt());
    if (cached != null) {
      setState(() => _thumbnail = cached);
      return;
    }

    final data = await entity.thumbnailData;
    if (!mounted || data == null) return;

    LeafImageLruCache.setData(entity, widget.size.toInt(), data);
    setState(() => _thumbnail = data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: Stack(
                children: [
                  if (_thumbnail != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        _thumbnail!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (widget.isActive)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.black.withValues(alpha: 0.3),
                        ),
                        child: const Icon(
                          Icons.check_sharp,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: widget.size,
            child: Text(
              widget.displayName,
              textAlign: TextAlign.center,
              style: widget.nameStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
