import 'package:flutter/material.dart';
import 'package:keeplo/widgets/simple_image.dart';
import 'package:widget_zoom/widget_zoom.dart';

class VahulInfo extends StatelessWidget{
  const VahulInfo({super.key, required this.imagePath, required this.description});
  final String imagePath;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: WidgetZoom(
                heroAnimationTag: 'vaulCover',
                zoomWidget: SimpleImage(imagePath: imagePath, isBoxCover: false,)
            )
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Descripción: ", style: TextStyle(fontSize: 22, color: Colors.white)),
              Text(
                description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}