import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:keeplo/bloc/auth_bloc/auth_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/screens/main/auth_template_screen.dart';
import 'package:keeplo/utils/simple_toast.dart';
import 'package:keeplo/widgets/main/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>() ;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocuesNode = FocusNode();

  void _unFocusNode() {
    _emailFocusNode.unfocus();
    _passwordFocuesNode.unfocus();
  }

  Future<void> login() async {
    try {
      context.read<AuthBloc>().add(LoginSubmitted());
    } catch (e) {
      SimpleToast.error(context: context, message: e.toString(), size: 14, iconSize: 50);
    }
  }

  Future<void> validateForm() async {
    _unFocusNode();
    if (formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      await login();
    } else {
      SimpleToast.info(context: context, message: "¡Oops! Revisa los campos y vuelve a intentarlo.", size: 14, iconSize: 60);
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocuesNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget loginForm = LoginForm(
      callback: validateForm,
      formKey: formKey,
      emailFocusNode: _emailFocusNode,
      passwordFocuesNode: _passwordFocuesNode,
    );

    return AuthTemplateScreen(
      action: validateForm,
      form: loginForm
    );
  }
}
