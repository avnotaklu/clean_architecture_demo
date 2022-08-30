import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  static final ImagePicker _picker = ImagePicker();
  static Future<XFile?> pickGalleryImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  static Future<PlatformFile?> pickFile(List<String>? allowed) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,
    allowedExtensions: allowed
    );

    if (result != null) {
      result.files.single.path;
      return result.files.single;
    } else {
      return null;
    }
  }

  static Future openfile({required String url, required String filename}) async {
    final file = await downloadFile(url, filename);
    if (file == null) return;
    OpenFile.open(file.path);
  }

  static Future<File?> downloadFile(String url, String name) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$name');
      final bytes = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes, followRedirects: false, receiveTimeout: 0));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(bytes.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
