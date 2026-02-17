# LeafMultipartFile

A file model for multipart uploads that supports remote `Uri`, local `XFile`, and raw `Uint8List` sources. Extends `UIModelV2<String>` with UUID-based payload identification. Provides `toMultipartFile()` for direct conversion to Dio's `MultipartFile`, plus file metadata extraction (extension, name, path, bytes) and allowed-extension validation.

## API Reference

### Constants

| Constant | Value | Description |
|----------|-------|-------------|
| `kDefaultLeafAllowFiles` | `['.jpg', '.jpeg', '.png']` | Default allowed file extensions |

### LeafMultipartFile (extends UIModelV2\<String\>)

#### Constructor Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `payload` | `String?` | Yes | Unique identifier (typically UUID) |
| `uri` | `Uri?` | No | Remote file URI |
| `xFile` | `XFile?` | No | Local file reference |
| `bytes` | `Uint8List?` | No | Raw file bytes |
| `fileName` | `String?` | No | File name (used with bytes source) |

> At least one of `uri`, `xFile`, or `bytes` must be provided.

#### Factory Constructors

| Factory | Parameters | Description |
|---------|------------|-------------|
| `LeafMultipartFile.fromUri()` | `Uri uri, {String? payload}` | Create from remote URI; auto-generates UUID v5 payload |
| `LeafMultipartFile.fromXFile()` | `XFile xFile, {String? payload}` | Create from local XFile; auto-generates UUID v5 payload |
| `LeafMultipartFile.fromBytes()` | `Uint8List bytes, {String? payload, required String fileName}` | Create from raw bytes; auto-generates UUID v4 payload |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `toMultipartFile()` | `Future<MultipartFile>` | Convert to Dio `MultipartFile` with auto-detected MIME type |
| `getHttpUri()` | `Uri?` | Returns URI only if scheme is HTTP/HTTPS |
| `getFileBytes()` | `Future<Uint8List?>` | Returns bytes directly or reads from XFile path |
| `getExtension()` | `String?` | File extension (e.g., `'.jpg'`) |
| `getFileName()` | `String?` | File name with extension |
| `getPath()` | `String?` | Full path string (non-HTTP URI or XFile) |
| `checkAllowExt([List<String> allowExt])` | `bool` | Whether extension is in allowed list |
| `pipeCheckAllowExt([List<String> allowExt])` | `LeafMultipartFile?` | Returns `this` if allowed, `null` otherwise |

## Usage

### From Remote URI

```dart
final file = LeafMultipartFile.fromUri(
  Uri.parse('https://example.com/photo.jpg'),
);
print(file.getExtension()); // '.jpg'
print(file.getHttpUri());   // Uri(https://example.com/photo.jpg)
```

### From Local File

```dart
final file = LeafMultipartFile.fromXFile(xFile);
final bytes = await file.getFileBytes();
final name = file.getFileName();
```

### From Raw Bytes

```dart
final file = LeafMultipartFile.fromBytes(
  imageBytes,
  fileName: 'profile.png',
);
```

### Convert to Dio MultipartFile for Upload

```dart
final leafFile = LeafMultipartFile.fromXFile(xFile);
final multipart = await leafFile.toMultipartFile();

final formData = FormData.fromMap({
  'avatar': multipart,
});

await service.post<User, Null>('/users/1/avatar', data: formData);
```

### Upload Multiple Images

```dart
final multiparts = await Future.wait(
  files.map((f) => f.toMultipartFile()),
);

final formData = FormData.fromMap({
  'images': multiparts,
});
```

### Extension Validation

```dart
final file = LeafMultipartFile.fromUri(uri);
if (file.checkAllowExt()) {
  // file is .jpg, .jpeg, or .png
}

// Or use pipe pattern
final validated = file.pipeCheckAllowExt(['.jpg', '.png']);
if (validated != null) {
  uploadFile(validated);
}
```
