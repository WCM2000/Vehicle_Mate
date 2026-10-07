import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class GoogleDriveService {
  GoogleDriveService()
      : _googleSignIn = GoogleSignIn(
          scopes: [drive.DriveApi.driveAppdataScope],
        );

  final GoogleSignIn _googleSignIn;
  static const _backupFileName = 'vehicle_mate_backup.sqlite';

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Future<GoogleSignInAccount?> signInSilently() =>
      _googleSignIn.signInSilently();

  Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();

  Future<void> signOut() => _googleSignIn.signOut();

  Future<drive.DriveApi> _driveApi() async {
    final account = _googleSignIn.currentUser ?? await _googleSignIn.signIn();
    if (account == null) {
      throw StateError('Google sign-in was cancelled');
    }
    final client = await _googleSignIn.authenticatedClient();
    if (client == null) {
      throw StateError('Could not authenticate with Google Drive');
    }
    return drive.DriveApi(client);
  }

  Future<String> _dbFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, 'vehicle_mate.sqlite');
  }

  Future<drive.File?> _findBackupFile(drive.DriveApi api) async {
    final result = await api.files.list(
      spaces: 'appDataFolder',
      q: "name = '$_backupFileName'",
      $fields: 'files(id, name, modifiedTime)',
    );
    final files = result.files;
    if (files == null || files.isEmpty) return null;
    return files.first;
  }

  Future<void> backup() async {
    final api = await _driveApi();
    final bytes = await File(await _dbFilePath()).readAsBytes();
    final media = drive.Media(Stream.value(bytes), bytes.length);

    final existing = await _findBackupFile(api);
    if (existing != null) {
      await api.files.update(drive.File(), existing.id!, uploadMedia: media);
    } else {
      final metadata = drive.File()
        ..name = _backupFileName
        ..parents = ['appDataFolder'];
      await api.files.create(metadata, uploadMedia: media);
    }
  }

  Future<DateTime?> lastBackupTime() async {
    final api = await _driveApi();
    final existing = await _findBackupFile(api);
    return existing?.modifiedTime;
  }

  /// Downloads the latest backup and overwrites the local database file.
  /// Returns false if no backup exists on Drive.
  Future<bool> restore() async {
    final api = await _driveApi();
    final existing = await _findBackupFile(api);
    if (existing == null) return false;

    final media = await api.files.get(
      existing.id!,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    final bytes = <int>[];
    await for (final chunk in media.stream) {
      bytes.addAll(chunk);
    }

    await File(await _dbFilePath()).writeAsBytes(bytes, flush: true);
    return true;
  }
}
