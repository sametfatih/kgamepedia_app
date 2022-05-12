import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getFile(String fileName) async {
    final path = await getFilePath();
    return File('$path/$fileName.txt');
  }

  static Future<File> saveToFile(String fileName, dynamic data) async {
    final file = await getFile(fileName);

    return file.writeAsString(data);
  }

  static Future<String> readFromFile(String fileName) async {
    try {
      final file = await getFile(fileName);
      return await file.readAsString();
    } catch (e) {
      return 'Bilgilerinize ulaşılamadı kaydedip tekrar deneyiniz.';
    }
  }

  static Future deleteFile(String fileName) async {
    try {
      final file = await getFile(fileName);
      return await file.delete();
    } catch (e) {
      print('Silinecek veri bulunamadı.');
    }
  }
}
