import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class LeafFileManager {
  /// File

  static Future<bool> existsFile(File file) async {
    return file.existsSync();
  }

  static Future<bool> createOrUpdateFile(
    File file, {
    required dynamic content,
    bool encodeJson = false,
    bool flush = true,
  }) async {
    try {
      final isExists = await existsFile(file);
      if (!isExists) {
        file.createSync(recursive: true);
      }
      if (encodeJson) {
        file.writeAsStringSync(jsonEncode(content), flush: flush);
      } else {
        file.writeAsStringSync(content, flush: flush);
      }
      return true;
    } catch (e) {
      debugPrint('createOrUpdateFile Error: $e');
    }
    return false;
  }

  static Future<dynamic> readAsFile(
    File file, {
    bool decodeJson = false,
  }) async {
    try {
      final isExists = await existsFile(file);
      if (isExists) {
        String content = file.readAsStringSync();
        if (decodeJson) {
          return jsonDecode(content);
        }
        return content;
      }
    } catch (e) {
      debugPrint('readAsJson Error: $e');
    }
    return null;
  }

  static Future<Uint8List?> readAsBytesFile(File file) async {
    try {
      return await file.readAsBytes();
    } catch (e) {
      debugPrint('readAsBytesFile Error: $e');
    }
    return null;
  }

  static Future<File?> writeFile(
    File file, {
    required String content,
    bool flush = true,
  }) async {
    try {
      file.writeAsStringSync(jsonEncode(content), flush: flush);
      return file;
    } catch (e) {
      debugPrint('writeFile Error: $e');
    }
    return null;
  }

  static Future<File?> writeByteFile(
    File file, {
    required Uint8List bytes,
    bool flush = true,
  }) async {
    try {
      file.writeAsBytesSync(bytes, flush: flush);
      return file;
    } catch (e) {
      debugPrint('writeByteFile Error: $e');
    }
    return null;
  }

  static Future<File?> writeByteBufferFile(
    File file, {
    required ByteBuffer buffer,
    required ByteData byteData,
    bool flush = true,
  }) async {
    try {
      await file.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
        flush: flush,
      );
      return file;
    } catch (e) {
      debugPrint('writeByteBufferFile Error: $e');
    }
    return null;
  }

  static Future<bool> deleteFile(File file) async {
    try {
      final isExists = await existsFile(file);
      if (isExists) {
        file.deleteSync(recursive: true);
        return true;
      }
    } catch (e) {
      debugPrint('DeleteFile Error: $e');
    }
    return false;
  }

  /// Directory

  static Future<void> deleteTemporaryDir() async {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  static Future<void> deleteDocumentDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  static Future<void> deleteSupportDir() async {
    final appDir = await getApplicationSupportDirectory();
    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  static Future<void> deleteExternalStorageDir() async {
    final appDir = await getExternalStorageDirectories();
    if (appDir != null) {
      for (var dir in appDir) {
        if (dir.existsSync()) {
          dir.deleteSync(recursive: true);
        }
      }
    }
  }

  static Future<Directory> getTemporaryDirectoryDir() async {
    return await getTemporaryDirectory();
  }

  static Future<String> getTemporaryDirectoryPath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  static Future<Directory> getApplicationDocumentsDirectoryDir() async {
    return await getApplicationDocumentsDirectory();
  }

  static Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> getApplicationDocumentsCreateDirectoryPath(
    String folderName,
  ) async {
    final Directory appDocDir = await getApplicationDocumentsDirectoryDir();
    final Directory appDocDirFolder = Directory(
      '${appDocDir.path}/$folderName/',
    );
    if (await appDocDirFolder.exists()) {
      return appDocDirFolder.path;
    }
    final Directory appDocDirNewFolder = await appDocDirFolder.create(
      recursive: true,
    );
    return appDocDirNewFolder.path;
  }
}
