import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:keeplo/theme/app_theme.dart';

class SimpleInput extends StatefulWidget {
  const SimpleInput({
    super.key,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.keyboardType,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.maxLength,
    this.contentPadding,
    this.onTap,
    this.validator,
    this.onEditingComplete,
    this.initialValue,
    this.inputDecoration,
    this.controller,
    this.maxLines = 1,
    this.showMaxLenght = false,
    this.isPassword = false,
    this.focusNode,
    this.obscureText = false,
    required this.name,
  });

  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final bool obscureText;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback? onTap;
  final bool showMaxLenght;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool isPassword;
  final String name;
  final Function()? onEditingComplete;
  final String? initialValue;
  final int maxLines;
  final InputDecoration? inputDecoration;
  final TextEditingController? controller;

  @override
  State<SimpleInput> createState() => _SimpleInputState();
}

class _SimpleInputState extends State<SimpleInput> {
    late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  void changeObscureText() => setState(() => obscureText = !obscureText);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      obscureText: obscureText,
      style: widget.textStyle,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      validator: widget.validator,
      decoration: widget.inputDecoration ?? InputDecoration(
        counterText: widget.showMaxLenght ? null : '',
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.secondary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.error, width: 3),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.error, width: 3),
        ),
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(16),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: changeObscureText,
                icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
      name: widget.name,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}