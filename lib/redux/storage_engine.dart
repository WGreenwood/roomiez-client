import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:redux_persist/redux_persist.dart';
import 'package:path_provider/path_provider.dart';

class RoomiezStorageEngine extends StorageEngine {
  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _localFile async {
    final localPath = await _localPath;
    return File('$localPath/roomiez_state.json');
  }

  /// Save state ([data] could be null)
  Future<void> save(Uint8List data) async {
    final file = await _localFile;
    if (data == null) {
      await file.delete();
      return;
    }
    final json = String.fromCharCodes(data);
    await file.writeAsString(json, flush: true);
  }

  /// Load state (can return null)
  Future<Uint8List> load() async {
    final file = await _localFile;
    try {
      String json = await file.readAsString();
      return Uint8List.fromList(json.codeUnits);
    } catch (e) {
      return null;
    }
  }
}