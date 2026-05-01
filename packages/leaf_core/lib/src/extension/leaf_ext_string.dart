import 'package:path/path.dart' as p;

extension StringPath on String {
  String extension() {
    return p.extension(this);
  }

  String fileName() {
    return p.basename(this);
  }
}
