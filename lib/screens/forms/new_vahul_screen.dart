import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/vahul_actions.dart';
import 'package:keeplo/widgets/forms/simple_input.dart';

class NewVahulScreen extends StatefulWidget {
  const NewVahulScreen({super.key});
  static const String routeName = 'new-vahul-screen';

  @override
  State<NewVahulScreen> createState() => _NewVahulScreenState();
}

class _NewVahulScreenState extends State<NewVahulScreen> {
  Color _colorSelected = Colors.blue;

  void _onColorSelected(Color color) {
    setState(() {
      _colorSelected = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo baúl", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
      ),
      backgroundColor: AppTheme.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              SimpleInput(
                onChange: (value) => context.read<AuthBloc>().add(EmailChange(value!)),
                textStyle: TextStyle(fontSize: 16.sp),
                name: 'name',
                hintText: 'Nombre',
                keyboardType: TextInputType.emailAddress,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                //focusNode: widget.emailFocusNode,
                maxLength: 60,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'El nombre del baúl es obligatorio.'),
                  FormBuilderValidators.minLength(3, errorText: 'El nombre del baúl es muy corto.'),
                  FormBuilderValidators.maxLength(40, errorText: 'El nombre del baúl es demasiado grande')
                ]),
                onEditingComplete: () {
                  //FocusScope.of(context).requestFocus(widget.passwordFocuesNode);
                },
              ),
              SizedBox(height: 20,),
              SimpleInput(
                //onChange: (value) => context.read<AuthBloc>().add(EmailChange(value!)),
                textStyle: TextStyle(fontSize: 16.sp),
                name: 'description',
                hintText: 'Descripición',
                keyboardType: TextInputType.emailAddress,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                //focusNode: widget.emailFocusNode,
                maxLength: 60,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.minLength(3, errorText: 'La descripción es muy corta.'),
                  FormBuilderValidators.maxLength(40, errorText: 'La descripción es muy extensa.')
                ]),
                onEditingComplete: () {
                  //FocusScope.of(context).requestFocus(widget.passwordFocuesNode);
                },
              ),
              SizedBox(height: 20,),
              Text("Color:", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () => VahulActions.openColorSelection(context: context, onColorChanged: _onColorSelected),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _colorSelected,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: Colors.white
                    )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Imagen:", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
              SizedBox(height: 14,),
              GestureDetector(
                onTap: () => VahulActions.openImageTypeSelection(context: context),
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/icons/add_image.svg",
                    height: 90,
                    width: 90,
                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}