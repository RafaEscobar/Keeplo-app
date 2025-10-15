import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keeplo/bloc/auth_bloc/auth_bloc.dart';
import 'package:keeplo/bloc/auth_bloc/auth_event.dart';
import 'package:keeplo/bloc/auth_bloc/auth_state.dart';
import 'package:keeplo/screens/main/login_screen.dart';
import 'package:keeplo/services/preferences.dart';
import 'package:keeplo/theme/app_theme.dart';
import 'package:keeplo/utils/responsive.dart';
import 'package:keeplo/utils/simple_toast.dart';
import 'package:keeplo/widgets/simple_modal.dart';

class DashHeader extends StatelessWidget implements PreferredSize{
  const DashHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _onLogout(BuildContext context) {
    Preferences.token = '';
    context.read<AuthBloc>().add(AuthStateClean());
    context.goNamed(LoginScreen.routeName);
  }

  void _openProfile({required BuildContext context, required String name, required String email}){
    print("TOKEN: ${Preferences.token}");
    SimpleModal.openModal(
      context: context,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (sheetContext, state) {
          if (state.status == AuthStatus.closedSession) {
            Navigator.of(sheetContext).pop();
            _onLogout(context);
          } else if(state.status == AuthStatus.loading) {
            showDialog(
              context: context,
              builder:(context) => Center(
                child: CircularProgressIndicator(color: Colors.white,)
              ,)
            );
          }
        },
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text("Perfil", style: TextStyle(fontSize: Responsive.regularTextSize(context), color: Colors.white, fontWeight: FontWeight.w600),),
              SizedBox(height: 16,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(name, style: TextStyle(fontSize: Responsive.sizeModalOptions(context), color: Colors.white),),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(email, style: TextStyle(fontSize: Responsive.sizeModalOptions(context), color: Colors.white),),
              ),
              SizedBox(height: 36,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      SimpleToast.info(context: context, message: "Proximamente", size: 14, iconSize: 60);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        spacing: 6,
                        children: [
                          Icon(Icons.edit, color: Colors.white, size: Responsive.modalIconSize(context),),
                          Text("Editar perfil", style: TextStyle(fontSize: Responsive.sizeModalText(context), color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.read<AuthBloc>().add(LogoutSubmitted()),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        spacing: 6,
                        children: [
                          Icon(Icons.login_rounded, color: Colors.white, size: Responsive.modalIconSize(context),),
                          Text("Cerrar sesión", style: TextStyle(fontSize: Responsive.sizeModalText(context), color: Colors.white),),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = context.read<AuthBloc>();
    return AppBar(
      backgroundColor: AppTheme.primaryTwo,
      leading: null,
      automaticallyImplyLeading: false,
      title: Text("Mis baúles", style: TextStyle(fontSize: Responsive.regularTextSize(context))),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 14),
          child: GestureDetector(
            onTap: () => _openProfile(context: context, name: bloc.state.user!.fullName, email: bloc.state.user!.email),
            child: Icon(Icons.person, size: context.isTabletLandscape ? 38 : 27),
          ),
        )
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}