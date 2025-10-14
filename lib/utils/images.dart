import 'dart:io';
import 'dart:typed_data';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:ui' as ui;
import 'dart:math';

class Images {
  static Future<MultipartFile> getMultipartFile(
    String name,
    File image, {
    int maxSizeBytes = 4 * 1024 * 1024,
    int qualityReduced = 90,
    int maxWidth = 1080,
    int maxHeight = 1920,
  }) async {
    try {
      final originalBytes = await image.readAsBytes(); //* Resguardo de bytes originales de la imagen
      final originalSize = originalBytes.length; //* Resguardo de tamaño original de la imagen
      int quality = 100; //* Calidad estandar de la imagen

      // 1) Si excede tamaño 4MB, aplicar quality reducido
      if (originalSize > maxSizeBytes) {
        quality = qualityReduced;
      }

      // 2) Obtener dimensiones con dart:ui
      final codec = await ui.instantiateImageCodec(originalBytes);
      final frame = await codec.getNextFrame();
      final int width = frame.image.width; //* Ancho de la imagen
      final int height = frame.image.height; //* Alto de la imagen

      // 3) Calcular nuevo ancho/alto manteniendo aspect ratio si supera los máximos
      int targetWidth = width;
      int targetHeight = height;
      if (width > maxWidth || height > maxHeight) {
        final double scaleW = maxWidth / width;
        final double scaleH = maxHeight / height;
        final double scale = min(scaleW, scaleH);
        targetWidth = max(1, (width * scale).round());
        targetHeight = max(1, (height * scale).round());
      }

      // 4) Determinar formato (si quieres forzar jpeg para más ahorro, cambia aquí)
      final ext = p.extension(image.path).toLowerCase();
      final format = (ext == '.png') ? CompressFormat.png : CompressFormat.jpeg;

      // 5) Comprimir en memoria
      // ignore: unnecessary_nullable_for_final_variable_declarations
      final Uint8List? compressedBytes = await FlutterImageCompress.compressWithList(
        originalBytes,
        quality: quality,
        minWidth: targetWidth,
        minHeight: targetHeight,
        format: format,
      );

      // 6) Si la compresión falla, usar el original; si no, usar los bytes comprimidos
      final usedBytes = (compressedBytes != null && compressedBytes.isNotEmpty) ? compressedBytes : originalBytes;

      // 7) Nombre de archivo seguro
      final safeName = '${DateTime.now().millisecondsSinceEpoch}_${p.basename(image.path)}';

      return MultipartFile.fromBytes(
        usedBytes,
        filename: safeName,
      );
    } catch (e) {
      // 8): enviar el archivo original si algo falla
      final safeName = '${DateTime.now().millisecondsSinceEpoch}_${p.basename(image.path)}';
      return MultipartFile.fromFile(image.path, filename: safeName);
    }
  }
}