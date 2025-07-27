import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:keeplo/providers/app_provider.dart';
import 'package:keeplo/widgets/forms/simple_input.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocuesNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocuesNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isHorizontalTablet = context.read<AppProvider>().isHorizontalTablet(context);
    bool isTablet = context.read<AppProvider>().isTablet(context);
    return FormBuilder(
      key: _formKey,
      child: Column(
        spacing: isHorizontalTablet ? 10 : 0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(isHorizontalTablet) SizedBox(height: 20,),
          SimpleInput(
            textStyle: TextStyle(fontSize: isTablet ? 22 : 14),
            name: 'email',
            hintText: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            focusNode: _emailFocusNode,
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
            textStyle: TextStyle(fontSize: isTablet ? 22 : 14),
            name: 'password',
            focusNode: _passwordFocuesNode,
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
            onEditingComplete: () {},
          ),
        ],
      ),
    );
  }
}