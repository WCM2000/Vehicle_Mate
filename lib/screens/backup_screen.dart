import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/providers.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  GoogleSignInAccount? _account;
  DateTime? _lastBackup;
  bool _busy = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _restoreSession());
  }

  Future<void> _restoreSession() async {
    final service = ref.read(googleDriveServiceProvider);
    final account = await service.signInSilently();
    if (!mounted) return;
    setState(() => _account = account);
    if (account != null) await _refreshLastBackup();
  }

  Future<void> _refreshLastBackup() async {
    final service = ref.read(googleDriveServiceProvider);
    try {
      final time = await service.lastBackupTime();
      if (!mounted) return;
      setState(() => _lastBackup = time);
    } catch (_) {
      // Ignore; surfaced only when the user explicitly backs up or restores.
    }
  }

  Future<void> _signIn() async {
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final service = ref.read(googleDriveServiceProvider);
      final account = await service.signIn();
      setState(() => _account = account);
      if (account != null) await _refreshLastBackup();
    } catch (e) {
      setState(() => _message = 'Sign-in failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signOut() async {
    final service = ref.read(googleDriveServiceProvider);
    await service.signOut();
    setState(() {
      _account = null;
      _lastBackup = null;
    });
  }

  Future<void> _backup() async {
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final db = ref.read(databaseProvider);
      await db.close();
      final service = ref.read(googleDriveServiceProvider);
      await service.backup();
      ref.invalidate(databaseProvider);
      await _refreshLastBackup();
      setState(() => _message = 'Backup uploaded to Google Drive.');
    } catch (e) {
      ref.invalidate(databaseProvider);
      setState(() => _message = 'Backup failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restore() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore from Google Drive?'),
        content: const Text(
          'This replaces all data currently on this device with the latest '
          'Drive backup. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final db = ref.read(databaseProvider);
      await db.close();
      final service = ref.read(googleDriveServiceProvider);
      final restored = await service.restore();
      ref.invalidate(databaseProvider);
      setState(() {
        _message = restored
            ? 'Restored the latest backup from Google Drive.'
            : 'No backup was found on Google Drive.';
      });
    } catch (e) {
      ref.invalidate(databaseProvider);
      setState(() => _message = 'Restore failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signedIn = _account != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (signedIn) ...[
              Text('Signed in as ${_account!.email}'),
              const SizedBox(height: 8),
              TextButton(onPressed: _busy ? null : _signOut, child: const Text('Sign out')),
            ] else
              FilledButton.icon(
                onPressed: _busy ? null : _signIn,
                icon: const Icon(Icons.login),
                label: const Text('Sign in with Google'),
              ),
            const SizedBox(height: 24),
            Text(
              _lastBackup == null
                  ? 'No backup found on Google Drive yet.'
                  : 'Last backup: ${_lastBackup!.toLocal()}',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: (!signedIn || _busy) ? null : _backup,
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('Back up now'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: (!signedIn || _busy) ? null : _restore,
              icon: const Icon(Icons.cloud_download_outlined),
              label: const Text('Restore from Drive'),
            ),
            if (_busy) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
            ],
            if (_message != null) ...[
              const SizedBox(height: 24),
              Text(_message!),
            ],
          ],
        ),
      ),
    );
  }
}
