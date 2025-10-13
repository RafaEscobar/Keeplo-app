import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class Images {
  //* Método que tratar la imagen y asignar un nombre limpio
  static Future<MultipartFile> getMultipartFile(String name, File image) async {
    // 1. Limpiar el nombre base
    final safeName = name.replaceAll(RegExp(r'[^A-Za-z0-9_\-]'), '_');

    // 2. Obtener extensión del archivo original
    final ext = p.extension(image.path);

    // 3. Generar un identificador único corto
    final uuid = const Uuid().v4().substring(0, 8);

    // 4. Combinar todo
    final filename = '${safeName}_$uuid$ext';

    // 5. Crear el MultipartFile
    return await MultipartFile.fromFile(
      image.path,
      filename: filename,
    );
  }
}