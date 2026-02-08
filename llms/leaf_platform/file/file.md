# LeafFileManager

Static utility class for file and directory operations. File methods operate on `dart:io` `File` objects. Directory methods use `path_provider` to access platform-specific directories.

## API Reference

### LeafFileManager

#### File Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `existsFile(File file)` | `Future<bool>` | Checks if a file exists |
| `createOrUpdateFile(File file, {required dynamic content, bool encodeJson, bool flush})` | `Future<bool>` | Creates or updates a file; optionally JSON-encodes content |
| `readAsFile(File file, {bool decodeJson})` | `Future<dynamic>` | Reads file as string or JSON-decoded object |
| `readAsBytesFile(File file)` | `Future<Uint8List?>` | Reads file as bytes |
| `writeFile(File file, {required String content, bool flush})` | `Future<File?>` | Writes string content (JSON-encoded) to file |
| `writeByteFile(File file, {required Uint8List bytes, bool flush})` | `Future<File?>` | Writes bytes to file |
| `writeByteBufferFile(File file, {required ByteBuffer buffer, required ByteData byteData, bool flush})` | `Future<File?>` | Writes a byte buffer range to file |
| `deleteFile(File file)` | `Future<bool>` | Deletes a file recursively if it exists |

#### createOrUpdateFile Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `file` | `File` | required | Target file |
| `content` | `dynamic` | required | Content to write |
| `encodeJson` | `bool` | `false` | Whether to JSON-encode content before writing |
| `flush` | `bool` | `true` | Whether to flush after write |

#### Directory Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `deleteTemporaryDir()` | `Future<void>` | Deletes the temporary directory |
| `deleteDocumentDir()` | `Future<void>` | Deletes the application documents directory |
| `deleteSupportDir()` | `Future<void>` | Deletes the application support directory |
| `deleteExternalStorageDir()` | `Future<void>` | Deletes all external storage directories (Android) |
| `getTemporaryDirectoryDir()` | `Future<Directory>` | Returns the temporary directory |
| `getTemporaryDirectoryPath()` | `Future<String>` | Returns the temporary directory path |
| `getApplicationDocumentsDirectoryDir()` | `Future<Directory>` | Returns the documents directory |
| `getApplicationDocumentsDirectoryPath()` | `Future<String>` | Returns the documents directory path |
| `getApplicationDocumentsCreateDirectoryPath(String folderName)` | `Future<String>` | Creates a subfolder inside documents and returns its path |

## Usage

### Create or Update File

```dart
final file = File('/path/to/data.json');
final success = await LeafFileManager.createOrUpdateFile(
  file,
  content: {'key': 'value'},
  encodeJson: true,
);
```

### Read File

```dart
final data = await LeafFileManager.readAsFile(file, decodeJson: true);
```

### Read as Bytes

```dart
final bytes = await LeafFileManager.readAsBytesFile(file);
```

### Write Bytes

```dart
final result = await LeafFileManager.writeByteFile(
  file,
  bytes: imageBytes,
);
```

### Delete File

```dart
await LeafFileManager.deleteFile(file);
```

### Get Directory Paths

```dart
final tempPath = await LeafFileManager.getTemporaryDirectoryPath();
final docsPath = await LeafFileManager.getApplicationDocumentsDirectoryPath();
```

### Create Subfolder in Documents

```dart
final path = await LeafFileManager.getApplicationDocumentsCreateDirectoryPath(
  'downloads',
);
// e.g., '/data/user/0/com.example.app/app_flutter/downloads/'
```

### Clear Directories

```dart
await LeafFileManager.deleteTemporaryDir();
await LeafFileManager.deleteDocumentDir();
```
