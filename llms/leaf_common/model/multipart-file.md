# LeafMultipartFile

A file model for multipart uploads that supports both remote `Uri` and local `XFile` sources. Extends `UIModelV2<String>` with UUID-based payload identification. Provides file metadata extraction (extension, name, path, bytes) and allowed-extension validation.

## API Reference

### LeafMultipartFile (extends UIModelV2\<String\>)

#### Constructor Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `payload` | `String?` | Yes | Unique identifier (typically UUID v5) |
| `uri` | `Uri?` | Yes | Remote file URI |
| `xFile` | `XFile?` | Yes | Local file reference |

#### Factory Constructors

| Factory | Parameters | Description |
|---------|------------|-------------|
| `LeafMultipartFile.fromUri()` | `Uri uri, {String? payload}` | Create from remote URI; auto-generates UUID v5 payload |
| `LeafMultipartFile.fromXFile()` | `XFile xFile, {String? payload}` | Create from local XFile; auto-generates UUID v5 payload |

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `getHttpUri()` | `Uri?` | Returns URI only if scheme is HTTP/HTTPS |
| `getFileBytes()` | `Uint8List?` | Reads file bytes from XFile path |
| `getExtension()` | `String?` | File extension (e.g., `'.jpg'`) |
| `getFileName()` | `String?` | File name with extension |
| `getPath()` | `String?` | Full path string |
| `checkAllowExt([List<String> allowExt])` | `bool` | Whether extension is in allowed list |
| `pipeCheckAllowExt([List<String> allowExt])` | `LeafMultipartFile?` | Returns `this` if allowed, `null` otherwise |

#### Constants

| Constant | Value | Description |
|----------|-------|-------------|
| `kAllowFiles` | `['.jpg', '.jpeg', '.png']` | Default allowed file extensions |

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
final bytes = file.getFileBytes();
final name = file.getFileName();
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
