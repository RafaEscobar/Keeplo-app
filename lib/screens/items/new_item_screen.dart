import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:keeplo/bloc/bloc_barrel.dart';
import 'package:keeplo/bloc/item_bloc/item_event.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_event.dart';
import 'package:keeplo/bloc/new_item_bloc/new_item_state.dart';
import 'package:keeplo/models/item.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/utils/simple_toast.dart';
import 'package:keeplo/utils/vahul_actions.dart';
import 'package:keeplo/widgets/forms/add_image_.dart';
import 'package:keeplo/widgets/forms/simple_input.dart';
import 'package:keeplo/widgets/simple_button.dart';
import 'package:keeplo/widgets/simple_image.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});
  static const String routeName = 'new-item-screen';

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  FocusNode nameFocusNode = FocusNode();
  FocusNode observationsFocusNode = FocusNode();
  late TextEditingController _nameController;
  late TextEditingController _observationsController;
  bool localValue = true;
  double localAmount = 1;

  void runValidation() {
    NewItemBloc bloc = context.read<NewItemBloc>();
    if (!bloc.state.isEdition) {
      if (bloc.state.name.isNotEmpty && bloc.state.image != null && bloc.state.image!.path.isNotEmpty) {
        context.read<NewItemBloc>().add(ItemVahulIdChange(context.read<NewVahulBloc>().state.currentVahul!.id));
        context.read<NewItemBloc>().add(SubmitItemForm());
      } else {
        _onErroValidation();
      }
    } else {
      if (bloc.state.name.isNotEmpty) {
        context.read<NewItemBloc>().add(ItemVahulIdChange(context.read<NewVahulBloc>().state.currentVahul!.id));
        context.read<NewItemBloc>().add(SubmitItemUpdate()) ;
      } else {
        _onErroValidation();
      }
    }
  }

  void _onErroValidation() {
    context.read<NewItemBloc>().add(ItemFormErrorChange(true));
    SimpleToast.info(context: context, message: "Por favor, proporcione los campos obligatorios.", size: 14, iconSize: 50);
  }

  void _setData(Item item) {
    context.read<NewItemBloc>().add(ItemNameChange(item.name));
    context.read<NewItemBloc>().add(ItemObservationsChange(item.observations));
    context.read<NewItemBloc>().add(ItemVahulIdChange(item.vahulId));
    context.read<NewItemBloc>().add(StatusEntityChange(item.status));
    context.read<NewItemBloc>().add(ItemAmountChange(item.amount));
    localValue = item.status == 1;
    localAmount = (item.amount).toDouble();
  }

  @override
  void initState() {
    super.initState();
    Item? item = context.read<NewItemBloc>().state.currentItem;
    _nameController = TextEditingController(text: item?.name ?? '');
    _observationsController = TextEditingController(text: item?.observations ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (item != null) _setData(item);
    },);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _observationsController.dispose();
    nameFocusNode.dispose();
    observationsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEdition = context.read<NewItemBloc>().state.isEdition;
    Item? vahul = context.read<NewItemBloc>().state.currentItem;
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo item", style: TextStyle(fontSize: Responsive.regularTextSize(context), color: Colors.white, fontWeight: FontWeight.w600),),
      ),
      backgroundColor: AppTheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<NewItemBloc, NewItemState>(
            listener: (context, state) {
              if (state.status == NewItemStatus.success) {
                context.read<ItemBloc>().add(GetItemsEvent());
                context.read<ItemBloc>().add(ItemNewPageEvent(1));
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
                //Navigator.of(context).pop();
              } else if (state.status == NewItemStatus.fail) {
                SimpleToast.info(context: context, message: state.messageError, size: 14, iconSize: 50);
                context.read<NewItemBloc>().add(ItemStatusChange(NewItemStatus.initial));
              }
            },
            builder: (context, state) {
              return Padding(
                padding: context.isTabletLandscape ? EdgeInsetsGeometry.symmetric(horizontal: 180) : EdgeInsetsGeometry.zero,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
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
                            SizedBox(height: 20,),
                            SimpleInput(
                              controller: _nameController,
                              onChange: (value) => context.read<NewItemBloc>().add(ItemNameChange(value!)),
                              textStyle: TextStyle(fontSize: Responsive.regularTextSize(context)),
                              name: 'name',
                              hintText: 'Nombre*',
                              keyboardType: TextInputType.emailAddress,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              focusNode: nameFocusNode,
                              maxLength: 60,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(errorText: 'El nombre del item es obligatorio.'),
                                FormBuilderValidators.minLength(3, errorText: 'El nombre del item es muy corto.'),
                                FormBuilderValidators.maxLength(40, errorText: 'El nombre del item es demasiado grande')
                              ]),
                              onEditingComplete: () {
                                FocusScope.of(context).requestFocus(observationsFocusNode);
                              },
                            ),
                            SizedBox(height: 10,),
                            Visibility(
                              visible: state.formError && state.name.isEmpty,
                              child: Text("El nombre del item es obligatorio", style: TextStyle(color: AppTheme.error, fontWeight: FontWeight.bold))
                            ),
                            SizedBox(height: 20,),
                            SimpleInput(
                              controller: _observationsController,
                              onChange: (value) => context.read<NewItemBloc>().add(ItemObservationsChange(value!)),
                              textStyle: TextStyle(fontSize: Responsive.regularTextSize(context)),
                              name: 'description',
                              hintText: 'Descripición',
                              keyboardType: TextInputType.emailAddress,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              focusNode: observationsFocusNode,
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
                            Text("Cantidad:*", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            SpinBox(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2),
                                ),
                              ),
                              textStyle: TextStyle(color: Colors.white),
                              iconColor: WidgetStateProperty.all(Colors.white),
                              cursorColor: Colors.white,
                              min: 1,
                              max: 200,
                              value: localAmount,
                              onChanged: (value) {
                                localAmount = value;
                                context.read<NewItemBloc>().add(ItemAmountChange((value).toInt()));
                              }
                            ),
                            SizedBox(height: 20,),
                            Text("Estatus del item:", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                            Switch(
                              value: localValue,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                context.read<NewItemBloc>().add(StatusEntityChange(value ? 1 : 0));
                                setState(() {
                                  localValue = value;
                                });
                              }
                            ),
                            SizedBox(height: 20,),
                            Text("Imagen:*", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            Visibility(
                              visible: state.formError && state.image!.path.isEmpty,
                              child: Text("La imagen del item es obligatoria", style: TextStyle(color: AppTheme.error, fontWeight: FontWeight.bold))
                            ),
                            SizedBox(height: 14,),
                            GestureDetector(
                              onTap: () => VahulActions.openImageTypeSelection(context: context, forVahuls: false),
                              child: Align(
                                alignment: Alignment.center,
                                child: AddImage(
                                  body: BlocSelector<NewItemBloc, NewItemState, File?>(
                                    selector: (state) => state.image,
                                    builder: (context, image) {
                                      return (image == null || image.path.isEmpty) ?
                                        (
                                          !isEdition ?
                                          SvgPicture.asset(
                                            "assets/icons/image.svg",
                                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                          ) :
                                          ClipOval(child: SimpleImage(imagePath: vahul!.image))
                                        ) :
                                        ClipOval(child: Image.file(File(image.path), fit: BoxFit.cover,));
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                          ],
                        ),
                      ),
                      if (state.status == NewItemStatus.loading)
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
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 18),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SimpleButton(
          text: "Guardar",
          callback: () {
            runValidation();
          },
          padding: EdgeInsets.symmetric(vertical: context.isTabletLandscape ? 6 : 8),
        ),
      ),
    );
  }
}

