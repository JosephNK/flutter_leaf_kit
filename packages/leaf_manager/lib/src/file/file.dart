import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:leaf_common/leaf_common.dart';
import 'package:path_provider/path_provider.dart';

class LFFileManager {
  static final LFFileManager _instance = LFFileManager._internal();

  static LFFileManager get shared => _instance;

  LFFileManager._internal();

  /// File
  ///

  Future<bool> createLocalFile(
    String path, {
    required String fileName,
    dynamic content,
  }) async {
    try {
      final file = File('$path/$fileName');
      file.createSync(recursive: true);
      if (content != null) {
        //file.writeAsStringSync(jsonEncode('{}'));
        file.writeAsStringSync(jsonEncode(content), flush: true);
      }
      return true;
    } catch (e) {
      Logging.d('createLocalFile e: $e');
      return false;
    }
  }

  Future<File> readLocalFileWithName(
    String path, {
    required String fileName,
  }) async {
    Logging.d('readLocalFileWithName: $path');
    return File('$path/$fileName');
  }

  Future<File> readLocalFilePath(String path) async {
    Logging.d('readLocalFilePath: $path');
    return File(path);
  }

  Future<Uint8List> readLocalByteFilePath(String path) async {
    final file = await readLocalFilePath(path);
    final bytes = await file.readAsBytes();
    return bytes;
  }

  Future<void> writeLocalFile(
    String path, {
    required String fileName,
    dynamic content,
  }) async {
    final file = File('$path/$fileName');
    file.writeAsStringSync(jsonEncode(content), flush: true);
  }

  Future<File> writeLocalByteFile(
    String path, {
    required String fileName,
    required Uint8List bytes,
  }) async {
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<void> writeLocalAssetFileCopy(
    String path, {
    required String fileName,
    required ByteBuffer buffer,
    required ByteData byteData,
  }) async {
    final file = File('$path/$fileName');
    await file.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
        flush: true);
  }

  Future<bool> deleteLocalFilePathWithName(
    String path, {
    required String fileName,
  }) async {
    try {
      final file = File('$path/$fileName');
      file.deleteSync(recursive: true);
      Logging.d('deleteLocalFilePathWithName success!');
      return true;
    } catch (e) {
      Logging.d('deleteLocalFilePathWithName e: $e');
      return false;
    }
  }

  Future<bool> deleteLocalFilePath(String path) async {
    try {
      final file = File(path);
      file.deleteSync(recursive: true);
      Logging.d('deleteLocalFilePath success!');
      return true;
    } catch (e) {
      Logging.d('deleteLocalFilePath e: $e');
      return false;
    }
  }

  Future<dynamic> readAsJson(File file) async {
    try {
      return jsonDecode(file.readAsStringSync());
    } catch (e) {
      Logging.d('readAsJson e: $e');
      return null;
    }
  }

  /// Directory
  ///

  Future<void> deleteTemporaryDir() async {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
    // final tempDir = await getTemporaryDirectory();
    // final libCacheDir = Directory('${tempDir.path}/libCachedImageData');
    // if (libCacheDir.existsSync()) {
    //   await libCacheDir.delete(recursive: true);
    // }
  }

  Future<void> deleteDocumentDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  Future<void> deleteSupportDir() async {
    final appDir = await getApplicationSupportDirectory();
    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  Future<void> deleteExternalStorageDir() async {
    final appDir = await getExternalStorageDirectories();
    if (appDir != null) {
      for (var dir in appDir) {
        if (dir.existsSync()) {
          dir.deleteSync(recursive: true);
        }
      }
    }
  }

  Future<Directory> getTemporaryDirectoryDir() async {
    return await getTemporaryDirectory();
  }

  Future<String> getTemporaryDirectoryPath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<Directory> getApplicationDocumentsDirectoryDir() async {
    return await getApplicationDocumentsDirectory();
  }

  Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> getApplicationDocumentsCreateDirectoryPath(
      String folderName) async {
    final Directory appDocDir = await getApplicationDocumentsDirectoryDir();
    final Directory appDocDirFolder =
        Directory('${appDocDir.path}/$folderName/');
    if (await appDocDirFolder.exists()) {
      return appDocDirFolder.path;
    }
    final Directory appDocDirNewFolder =
        await appDocDirFolder.create(recursive: true);
    return appDocDirNewFolder.path;
  }
}
