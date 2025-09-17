import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:keeplo/bloc/auth_bloc/auth_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/forms/simple_input.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({
    super.key,
    required this.callback,
    required this.formKey,
    required this.emailFocusNode,
    required this.passwordFocuesNode,
  });
  final Function() callback;
  final GlobalKey<FormBuilderState> formKey;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocuesNode;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    bool isHorizontal = context.isTabletLandscape;
    return FormBuilder(
      key: widget.formKey,
      child: Column(
        spacing: isHorizontal ? 10 : 0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(isHorizontal) SizedBox(height: 20,),
          SimpleInput(
            onChange: (value) => context.read<AuthBloc>().add(EmailChange(value!)),
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
            onChange: (value) => context.read<AuthBloc>().add(PasswordChange(value!)),
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