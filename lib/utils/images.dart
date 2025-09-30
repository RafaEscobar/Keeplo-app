import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';

class Images {
  //* Método que tratar la imagen y asignar un nombre limpio
  static Future<MultipartFile> getMultipartFile(String name, File image, String path) async {
    final safeName = name.replaceAll(RegExp(r'[^A-Za-z0-9_\-]'), '_'); //? Limpiamos el nombre de nuestro vahul

    final ext = p.extension(image.path); //? Obtenemos la extensión de nuestra imagen cargada
    final filename = '${safeName}_image$ext'; //? Generamos el nombre con: nombreLimpio_colorNúmerico_image_extension

    // Generamos el MultipartFile a partir de la imagen y el nombre construido
    final file = await MultipartFile.fromFile(
      path,
      filename: filename,
    );

    return file; // Retornamos la -construcción segura- de la imagen
  }
}