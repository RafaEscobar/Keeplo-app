import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/models/vahul.dart';
import 'package:keeplo/screens/vauls/vahul_details.dart';
import 'package:keeplo/widgets/simple_image.dart';

class VahulCard extends StatelessWidget {
  const VahulCard({super.key, required this.vahul, required this.callBack});
  final Vahul vahul;
  final Function() callBack;

  void _navigateToDetails(BuildContext context) {
    callBack();
    context.read<VahulBloc>().add(SetCurrentVahulEvent(vahul));
    context.goNamed(VahulDetails.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: SizedBox(
        child: Column(
          spacing: 10,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: ClipOval(
                child: SimpleImage(imagePath: vahul.img)

              ),
            ),
            Expanded(
              child: Text(
                vahul.name,
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}