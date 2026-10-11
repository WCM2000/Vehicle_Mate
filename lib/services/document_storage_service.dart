import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class DocumentStorageService {
  final _picker = ImagePicker();

  Future<XFile?> pick(ImageSource source) {
    return _picker.pickImage(source: source, maxWidth: 1600, imageQuality: 85);
  }

  /// Copies the picked file into the app's documents directory under
  /// compliance_docs/ and returns the saved path.
  Future<String> save(XFile file, {required String prefix}) async {
    final dir = await getApplicationDocumentsDirectory();
    final docsDir = Directory(p.join(dir.path, 'compliance_docs'));
    if (!await docsDir.exists()) await docsDir.create(recursive: true);

    final ext = p.extension(file.path).isEmpty ? '.jpg' : p.extension(file.path);
    final fileName = '${prefix}_${DateTime.now().millisecondsSinceEpoch}$ext';
    final savedPath = p.join(docsDir.path, fileName);
    await File(file.path).copy(savedPath);
    return savedPath;
  }
}
