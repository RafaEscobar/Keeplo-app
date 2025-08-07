import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

abstract class AuthState extends Equatable{
  AuthState();
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  List<Object?> get props => throw UnimplementedError();
}

//* Estado inicial generico para el AuthState
class AuthInitialState extends AuthState {}

//* Estados para validación de token
class AuthTokenValid extends AuthState {}
class AuthTokenInvalid extends AuthState {}
class AuthTokenError extends AuthState {
  final String messageError;
  AuthTokenError(this.messageError);

  @override
  List<Object?> get props => [messageError];
}