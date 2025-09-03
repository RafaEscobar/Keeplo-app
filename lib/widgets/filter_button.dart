import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_bloc.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.icon,
    required this.callback
  });
  final IconData icon;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    bool isOrder = context.watch<VahulBloc>().state.hasOrder;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: callback,
        splashColor: Colors.white.withAlpha(20),
        highlightColor: Colors.white.withAlpha(60),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: isOrder ?
            SvgPicture.asset(
              "assets/icons/up.svg",
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ) :
            SvgPicture.asset(
              "assets/icons/down.svg",
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            )
        ),
      ),
    );
  }
}