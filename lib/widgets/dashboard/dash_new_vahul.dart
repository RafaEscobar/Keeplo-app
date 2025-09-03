import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:keeplo/widgets/forms/simple_input.dart';
import 'package:keeplo/widgets/simple_modal.dart';

class DashNewVahul extends StatelessWidget {
  const DashNewVahul({super.key});

  void _openForm({required BuildContext context}){
    SimpleModal.openModal(
      context: context,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text("Nuevo baúl", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600),),
            SizedBox(height: 16,),
            SimpleInput(
              //onChange: (value) => context.read<AuthBloc>().add(EmailChange(value!)),
              textStyle: TextStyle(fontSize: 16.sp),
              name: 'name',
              hintText: 'Nombre',
              keyboardType: TextInputType.emailAddress,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              //focusNode: widget.emailFocusNode,
              maxLength: 60,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'El nombre del baúl es obligatorio.'),
                FormBuilderValidators.minLength(3, errorText: 'El nombre del baúl es muy corto.'),
                FormBuilderValidators.maxLength(40, errorText: 'El nombre del baúl es demasiado grande')
              ]),
              onEditingComplete: () {
                //FocusScope.of(context).requestFocus(widget.passwordFocuesNode);
              },
            ),
            SimpleInput(
              //onChange: (value) => context.read<AuthBloc>().add(EmailChange(value!)),
              textStyle: TextStyle(fontSize: 16.sp),
              name: 'description',
              hintText: 'Descripición',
              keyboardType: TextInputType.emailAddress,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              //focusNode: widget.emailFocusNode,
              maxLength: 60,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.minLength(3, errorText: 'La descripción es muy corta.'),
                FormBuilderValidators.maxLength(40, errorText: 'La descripción es muy extensa.')
              ]),
              onEditingComplete: () {
                //FocusScope.of(context).requestFocus(widget.passwordFocuesNode);
              },
            ),
            /*
            Align(
              alignment: Alignment.centerLeft,
              child: Text(name, style: TextStyle(fontSize: 24, color: Colors.white),),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(email, style: TextStyle(fontSize: 24, color: Colors.white),),
            ),
            SizedBox(height: 36,),
            */
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _openForm(context: context),
        splashColor: Colors.white.withAlpha(20),
        highlightColor: Colors.white.withAlpha(60),
        child: Container(
          width: 145,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 6,
            children: [
              Icon(Icons.add, color: Colors.white,),
              Text("Nuevo baúl", style: TextStyle(color: Colors.white),),
            ],
          )
        ),
      ),
    );
  }
}