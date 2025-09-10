import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_event.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_state.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/hexa_color.dart';
import 'package:keeplo/utils/simple_toast.dart';
import 'package:keeplo/utils/vahul_actions.dart';
import 'package:keeplo/widgets/forms/add_image_.dart';
import 'package:keeplo/widgets/forms/simple_input.dart';
import 'package:keeplo/widgets/simple_button.dart';

class NewVahulScreen extends StatefulWidget {
  const NewVahulScreen({super.key});
  static const String routeName = 'new-vahul-screen';

  @override
  State<NewVahulScreen> createState() => _NewVahulScreenState();
}

class _NewVahulScreenState extends State<NewVahulScreen> {
  Color _colorSelected = Colors.blue;
  FocusNode nameFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _onColorSelected(Color color) {
    String hexaColor = HexaColor.getCode(color);
    context.read<NewVahulBloc>().add(VahulColorChange(hexaColor));
    setState(() {
      _colorSelected = color;
    });
  }

  void runValidation() {
    NewVahulBloc bloc = context.read<NewVahulBloc>();
    if (bloc.state.name.isNotEmpty && bloc.state.image != null) {
      context.read<NewVahulBloc>().add(VahulUserIdChange(context.read<AuthBloc>().state.user!.id));
      context.read<NewVahulBloc>().add(SubmitVahulForm());
    } else {
      SimpleToast.info(context: context, message: "Por favor, proporcione los campos obligatorios.", size: 14, iconSize: 50);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    nameFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo baúl", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
      ),
      backgroundColor: AppTheme.primary,
      body: SafeArea(
        child: BlocConsumer<NewVahulBloc, NewVahulState>(
          listener: (context, state) {
            if (state.status == NewVahulStatus.success) {
              context.read<VahulBloc>().add(GetVahulesEvent());
              context.goNamed(DashboardScreen.routeName);
            } else if (state.status == NewVahulStatus.fail) {
              SimpleToast.info(context: context, message: state.messageError, size: 14, iconSize: 50);
              context.read<NewVahulBloc>().add(VahulStatusChange(NewVahulStatus.initial));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          SimpleInput(
                            controller: _nameController,
                            onChange: (value) => context.read<NewVahulBloc>().add(VahulNameChange(value!)),
                            textStyle: TextStyle(fontSize: 16.sp),
                            name: 'name',
                            hintText: 'Nombre*',
                            keyboardType: TextInputType.emailAddress,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            focusNode: nameFocusNode,
                            maxLength: 60,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(errorText: 'El nombre del baúl es obligatorio.'),
                              FormBuilderValidators.minLength(3, errorText: 'El nombre del baúl es muy corto.'),
                              FormBuilderValidators.maxLength(40, errorText: 'El nombre del baúl es demasiado grande')
                            ]),
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(descriptionFocusNode);
                            },
                          ),
                          SizedBox(height: 20,),
                          SimpleInput(

                            onChange: (value) => context.read<NewVahulBloc>().add(VahulDescriptionChange(value!)),
                            textStyle: TextStyle(fontSize: 16.sp),
                            name: 'description',
                            hintText: 'Descripición',
                            keyboardType: TextInputType.emailAddress,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            focusNode: descriptionFocusNode,
                            maxLength: 60,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.minLength(3, errorText: 'La descripción es muy corta.'),
                              FormBuilderValidators.maxLength(40, errorText: 'La descripción es muy extensa.')
                            ]),
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                          SizedBox(height: 20,),
                          Text("Color:", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {
                              nameFocusNode.unfocus();
                              descriptionFocusNode.unfocus();
                              VahulActions.openColorSelection(context: context, onColorChanged: _onColorSelected);
                            },
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
                          Text("Imagen:*", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                          SizedBox(height: 14,),
                          GestureDetector(
                            onTap: () => VahulActions.openImageTypeSelection(context: context),
                            child: Align(
                              alignment: Alignment.center,
                              child: AddImage(
                                body: BlocSelector<NewVahulBloc, NewVahulState, File?>(
                                  selector: (state) => state.image,
                                  builder: (context, image) {
                                    return (image == null || image.path.isEmpty) ? SvgPicture.asset(
                                        "assets/icons/image.svg",
                                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                      ) : ClipOval(child: Image.file(File(image.path), fit: BoxFit.cover,));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SimpleButton(
                            text: "Guardar",
                            callback: () {
                              runValidation();
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          SizedBox(height: 10,)
                        ],
                      )
                    ],
                  ),
                ),
                if (state.status == NewVahulStatus.loading)
                  Positioned.fill(
                    child: Container(
                      color: AppTheme.primary.withAlpha(200),
                      child: const Center(child: CircularProgressIndicator(backgroundColor: AppTheme.secondary,)),
                    ),
                  ),
              ],
            );
          },
        )
      ),
    );
  }
}