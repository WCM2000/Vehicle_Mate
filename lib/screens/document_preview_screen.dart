import 'dart:io';

import 'package:flutter/material.dart';

class DocumentPreviewScreen extends StatelessWidget {
  const DocumentPreviewScreen({super.key, required this.path, required this.title});

  final String path;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4,
          child: Image.file(File(path)),
        ),
      ),
    );
  }
}
