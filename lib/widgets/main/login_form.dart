import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/widgets/forms/simple_input.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({super.key, required this.callback, required this.formKey});
  final Function() callback;
  final GlobalKey<FormBuilderState> formKey;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocuesNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocuesNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            textStyle: TextStyle(fontSize: isHorizontal ? 38 : 16.sp),
            name: 'email',
            hintText: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            focusNode: _emailFocusNode,
            controller: _emailController,
            maxLength: 60,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'El correo electrónico es obligatorio.'),
              FormBuilderValidators.email(errorText: 'El correo electrónico no es válido.'),
              FormBuilderValidators.maxLength(60, errorText: 'El correo es demasiado grande')
            ]),
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(_passwordFocuesNode);
            },
          ),
          const SizedBox(height: 20),
          SimpleInput(
            textStyle: TextStyle(fontSize: isHorizontal ? 38 : 16.sp),
            name: 'password',
            focusNode: _passwordFocuesNode,
            controller: _passwordController,
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