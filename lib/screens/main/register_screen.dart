import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:keeplo/bloc/auth_bloc/auth_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/screens/main/auth_template_screen.dart';
import 'package:keeplo/utils/simple_toast.dart';
import 'package:keeplo/widgets/main/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>() ;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocuesNode = FocusNode();
  final FocusNode _nameFocuesNode = FocusNode();
  final FocusNode _lastNameFocuesNode = FocusNode();

  void _unFocusNode() {
    _emailFocusNode.unfocus();
    _passwordFocuesNode.unfocus();
  }

  Future<void> register() async {
    try {
      context.read<AuthBloc>().add(RegisterSubmitted());
    } catch (e) {
      SimpleToast.error(context: context, message: e.toString(), size: 14, iconSize: 50);
    }
  }

  Future<void> validateForm() async {
    _unFocusNode();
    if (formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      await register();
    } else {
      SimpleToast.info(context: context, message: "¡Oops! Revisa los campos y vuelve a intentarlo.", size: 14, iconSize: 60);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget registerForm = RegisterForm(
    callback: validateForm,
    formKey: formKey,
    nameFocusNode: _nameFocuesNode,
    lastNameFocuesNode: _lastNameFocuesNode,
    emailFocusNode: _emailFocusNode,
    passwordFocuesNode: _passwordFocuesNode,
  );

    return AuthTemplateScreen(
      action: validateForm,
      form: registerForm,
      isLogin: false,
    );
  }
}