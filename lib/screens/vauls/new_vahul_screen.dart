import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_event.dart';
import 'package:keeplo/bloc/new_vahul_bloc/new_vahul_state.dart';
import 'package:keeplo/bloc/vahul_bloc/vahul_event.dart';
import 'package:keeplo/models/vahul.dart';
import 'package:keeplo/screens/dashboard_screen.dart';
import 'package:keeplo/screens/vauls/vahul_details.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/utils/simple_toast.dart';
import 'package:keeplo/utils/vahul_actions.dart';
import 'package:keeplo/widgets/forms/add_image_.dart';
import 'package:keeplo/widgets/forms/simple_input.dart';
import 'package:keeplo/widgets/simple_button.dart';
import 'package:keeplo/widgets/simple_image.dart';

class NewVahulScreen extends StatefulWidget {
  const NewVahulScreen({super.key});
  static const String routeName = 'new-vahul-screen';

  @override
  State<NewVahulScreen> createState() => _NewVahulScreenState();
}

class _NewVahulScreenState extends State<NewVahulScreen> {
  FocusNode nameFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  void runValidation() {
    NewVahulBloc bloc = context.read<NewVahulBloc>();
    if (!bloc.state.isEdition) {
      if (bloc.state.name.isNotEmpty && bloc.state.image != null && bloc.state.image!.path.isNotEmpty) {
        context.read<NewVahulBloc>().add(VahulUserIdChange(context.read<AuthBloc>().state.user!.id));
        context.read<NewVahulBloc>().add(SubmitVahulForm());
      } else {
        _onErroValidation();
      }
    } else {
      if (bloc.state.name.isNotEmpty) {
        context.read<NewVahulBloc>().add(VahulUserIdChange(context.read<AuthBloc>().state.user!.id));
        context.read<NewVahulBloc>().add(SubmitVahulUpdateForm(context.read<NewVahulBloc>().state.currentVahul!.id));
      } else {
        _onErroValidation();
      }
    }
  }

  void _onErroValidation() {
    context.read<NewVahulBloc>().add(VahulFormErrorChange(true));
    SimpleToast.info(context: context, message: "Por favor, proporcione los campos obligatorios.", size: 14, iconSize: 50);
  }

  void _setData(Vahul vahul) {
    context.read<NewVahulBloc>().add(VahulNameChange(vahul.name));
    context.read<NewVahulBloc>().add(VahulDescriptionChange(vahul.description));
    context.read<NewVahulBloc>().add(VahulUserIdChange(vahul.userId));
  }

  @override
  void initState() {
    super.initState();
    Vahul? vahul = context.read<NewVahulBloc>().state.currentVahul;
    _nameController = TextEditingController(text: vahul?.name ?? '');
    _descriptionController = TextEditingController(text: vahul?.description ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (vahul != null) _setData(vahul);
    },);
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
    bool isEdition = context.read<NewVahulBloc>().state.isEdition;
    Vahul? vahul = context.read<NewVahulBloc>().state.currentVahul;
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo baúl", style: TextStyle(fontSize: Responsive.regularTextSize(context), color: Colors.white, fontWeight: FontWeight.w600),),
      ),
      backgroundColor: AppTheme.primary,
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          Future.microtask(() {
            if (context.mounted) {
              if (isEdition) {
                context.goNamed(VahulDetails.routeName);
              }
            }
          });
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<NewVahulBloc, NewVahulState>(
              listener: (context, state) {
                if (state.status == NewVahulStatus.success) {
                  context.read<VahulBloc>().add(GetVahulesEvent());
                  context.read<VahulBloc>().add(VahulNewPageEvent(1));
                  context.goNamed(DashboardScreen.routeName);
                } else if (state.status == NewVahulStatus.fail) {
                  SimpleToast.info(context: context, message: state.messageError, size: 14, iconSize: 50);
                  context.read<NewVahulBloc>().add(VahulStatusChange(NewVahulStatus.initial));
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: context.isTabletLandscape ? EdgeInsetsGeometry.symmetric(horizontal: 180) : EdgeInsetsGeometry.zero,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height*.88,
                      minHeight: MediaQuery.of(context).size.height*.88
                    ),
                    child: Stack(
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
                                    textStyle: TextStyle(fontSize: Responsive.regularTextSize(context)),
                                    name: 'name',
                                    hintText: 'Nombre*',
                                    keyboardType: TextInputType.text,
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
                                  SizedBox(height: 10,),
                                  Visibility(
                                    visible: state.formError && state.name.isEmpty,
                                    child: Text("El nombre del baúl es obligatorio", style: TextStyle(color: AppTheme.error, fontWeight: FontWeight.bold))
                                  ),
                                  SizedBox(height: 20,),
                                  SimpleInput(
                                    controller: _descriptionController,
                                    onChange: (value) => context.read<NewVahulBloc>().add(VahulDescriptionChange(value!)),
                                    textStyle: TextStyle(fontSize: Responsive.regularTextSize(context)),
                                    name: 'description',
                                    hintText: 'Descripición',
                                    keyboardType: TextInputType.text,
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
                                  Text("Imagen:*", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                                  SizedBox(height: 10,),
                                  Visibility(
                                    visible: state.formError && state.image!.path.isEmpty,
                                    child: Text("La imagen del baúl es obligatoria", style: TextStyle(color: AppTheme.error, fontWeight: FontWeight.bold))
                                  ),
                                  SizedBox(height: 14,),
                                  GestureDetector(
                                    onTap: () => VahulActions.openImageTypeSelection(context: context),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: AddImage(
                                        body: BlocSelector<NewVahulBloc, NewVahulState, File?>(
                                          selector: (state) => state.image,
                                          builder: (context, image) {
                                            return (image == null || image.path.isEmpty) ?
                                              (
                                                !isEdition ?
                                                SvgPicture.asset(
                                                  "assets/icons/image.svg",
                                                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                ) :
                                                ClipOval(child: SimpleImage(imagePath: vahul!.img))
                                              ) :
                                              ClipOval(child: Image.file(File(image.path), fit: BoxFit.cover,));
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
                                    padding: EdgeInsets.symmetric(vertical: context.isTabletLandscape ? 6 : 8),
                                  ),
                                  SizedBox(height: 16,)
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
                    ),
                  ),
                );
              },
            ),
          )
        ),
      ),
    );
  }
}

