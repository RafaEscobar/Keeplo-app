import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:keeplo/bloc/auth_bloc/auth_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/forms/simple_input.dart';

class RegisterForm extends StatefulWidget{
  const RegisterForm({
    super.key,
    required this.nameFocusNode,
    required this.lastNameFocuesNode,
    required this.emailFocusNode,
    required this.passwordFocuesNode,
    required this.callback,
    required this.formKey
  });
  final FocusNode nameFocusNode;
  final FocusNode lastNameFocuesNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocuesNode;
  final Function() callback;
  final GlobalKey<FormBuilderState> formKey;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  @override
  void dispose() {
    widget.nameFocusNode.dispose();
    widget.lastNameFocuesNode.dispose();
    widget.emailFocusNode.dispose();
    widget.passwordFocuesNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = Responsive.isHorizontalTablet(context);
    return FormBuilder(
      key: widget.formKey,
      child: Column(
        spacing: isHorizontal ? 10 : 0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(isHorizontal) SizedBox(height: 20,),
          SimpleInput(
            onChange: (name) => context.read<AuthBloc>().add(NameChange(name!)),
            textStyle: TextStyle(fontSize: isHorizontal ? 38 : 16.sp),
            name: 'name',
            hintText: 'Nombre',
            keyboardType: TextInputType.text,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            focusNode: widget.nameFocusNode,
            maxLength: 60,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'El nombre es obligatorio.'),
              FormBuilderValidators.minLength(3, errorText: 'El nombre es demasiado corto'),
              FormBuilderValidators.maxLength(40, errorText: 'El nombre es demasiado grande')
            ]),
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(widget.lastNameFocuesNode);
            },
          ),
          const SizedBox(height: 20),
          SimpleInput(
            onChange: (lastName) => context.read<AuthBloc>().add(LastNameChange(lastName!)),
            textStyle: TextStyle(fontSize: isHorizontal ? 38 : 16.sp),
            name: 'last_name',
            hintText: 'Apellido',
            keyboardType: TextInputType.text,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            focusNode: widget.lastNameFocuesNode,
            maxLength: 60,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'El apellido es obligatorio.'),
              FormBuilderValidators.minLength(3, errorText: 'El apellido es demasiado corto'),
              FormBuilderValidators.maxLength(80, errorText: 'El apellido es demasiado grande')
            ]),
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(widget.emailFocusNode);
            },
          ),
          const SizedBox(height: 20),
          SimpleInput(
            onChange: (email) => context.read<AuthBloc>().add(EmailChange(email!)),
            textStyle: TextStyle(fontSize: isHorizontal ? 38 : 16.sp),
            name: 'email',
            hintText: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            focusNode: widget.emailFocusNode,
            maxLength: 60,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'El correo electrónico es obligatorio.'),
              FormBuilderValidators.email(errorText: 'El correo electrónico no es válido.'),
              FormBuilderValidators.maxLength(60, errorText: 'El correo es demasiado grande')
            ]),
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(widget.passwordFocuesNode);
            },
          ),
          const SizedBox(height: 20),
          SimpleInput(
            onChange: (password) => context.read<AuthBloc>().add(PasswordChange(password!)),
            textStyle: TextStyle(fontSize: isHorizontal ? 38 : 16.sp),
            name: 'password',
            focusNode: widget.passwordFocuesNode,
            obscureText: true,
            hintText: 'Contraseña',
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            maxLength: 16,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Proporciona una contraseña'),
              FormBuilderValidators.maxLength(16, errorText: 'La contraseña es demasiado grande'),
              FormBuilderValidators.minLength(8, errorText: 'La contraseña es demasiado corta'),
            ]),
            isPassword: true,
            onEditingComplete: widget.callback,
          ),
        ],
      ),
    );
  }
}