import 'dart:io';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_bloc.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_event.dart';
import 'package:keeplo/widgets/simple_modal.dart';

class VahulActions {
  static void openColorSelection({required BuildContext context, required Function(Color) onColorChanged}){
    SimpleModal.openModal(
      context: context,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text("Selecciona el color de tu baúl", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
            ColorPicker(
              onColorChanged: (Color color) => onColorChanged(color),
              width: 40,
              height: 40,
              borderRadius: 30,
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.wheel: true,
                ColorPickerType.accent: false,
                ColorPickerType.primary: false,
                ColorPickerType.both: false,
                ColorPickerType.custom: false,
              },
            ),
          ],
        ),
      )
    );
  }

  static Future<void> _pickImage({required BuildContext context, required ImageSource source}) async {
    try {
      Navigator.of(context).pop();
      final picker = ImagePicker();
      final currentImage = await picker.pickImage(source: source);
      if (context.mounted) {
        if (null != currentImage) context.read<NewVahulBloc>().add(VahulImageChange(File(currentImage.path)));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static void openImageTypeSelection({required BuildContext context}){
    SimpleModal.openModal(
      context: context,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text("¿Dónde buscamos la imagen?", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _pickImage(context: context, source: ImageSource.gallery),
                  child: Column(
                    spacing: 6,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/gallery.svg",
                        height: 40,
                        width: 40,
                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                      Text("Galería", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () => _pickImage(context: context, source: ImageSource.camera),
                  child: Column(
                    spacing: 6,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/camera.svg",
                        height: 40,
                        width: 40,
                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                      Text("Cámara", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                    ],
                  ),
                )

              ],
            )
          ],
        ),
      )
    );
  }
}