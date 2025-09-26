import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/item_bloc/item_bloc.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/models/vahul.dart';
import 'package:keeplo/screens/vauls/vahul_details.dart';

class VahulCard extends StatelessWidget {
  const VahulCard({super.key, required this.vahul, required this.callBack});
  final Vahul vahul;
  final Function() callBack;

  void _navigateToDetails(BuildContext context) {
    callBack();
    context.read<ItemBloc>().add(SetItemEvent(vahul));
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
                child: Image.network(
                  "https://i.postimg.cc/kGTvjRkW/1907903.png",
                  //vahul.img,
                  fit: BoxFit.cover,
                ),
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