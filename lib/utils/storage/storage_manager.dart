import 'dart:io';
import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final storageManagerProvider = Provider<StorageManager>((ref) {
  return StorageManager();
});

class StorageManager {
  Future<File> createFile(Uint8List bytes, String extension) async {
    final filePath = '${await _localPath}/file-1.$extension';
    return File(filePath).writeAsBytes(bytes);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
