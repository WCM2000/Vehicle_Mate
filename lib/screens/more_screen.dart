import 'package:flutter/material.dart';

import 'backup_screen.dart';
import 'insights_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.insights_outlined),
            title: const Text('Insights'),
            subtitle: const Text('Expense, quota, and efficiency charts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const InsightsScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.cloud_sync_outlined),
            title: const Text('Backup & restore'),
            subtitle: const Text('Google Drive backup for your data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BackupScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
