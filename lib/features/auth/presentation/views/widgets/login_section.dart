import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/features_admin/admin_home/presentation/views/home_admin_view.dart';
import 'package:restaurant_management/models/user/user.dart';

import '../../../../../core/widgets/buttons.dart';
import '../../../../../core/widgets/custom_TextformField.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../utility/functions/validate_functions.dart';
import '../../../../../utility/helpers.dart';
import '../../../../../utility/size_config.dart';
import '../../../../root/presentation/views/root.dart';
import '../../viewModel/login_cubit/login_cubit.dart';


class LoginSection extends StatelessWidget {
  late String _email;
  late String _password;
  LoginSection({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: 'Email',
                onSaved: (value) => _email = value!,
                icon: Icons.email_outlined,
                validator: validateEmail,
              ),
              SizedBox(
                height: SizeConfig.space * 2,
              ),
              CustomTextFormField(
                onSaved: (value) => _password = value!,
                labelText: 'Password',
                icon: Icons.lock_outline,
                validator: validatePassword,
                isPassword: true,
              )
            ],
          ),
        ),
        BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailureState) {
              snackBarShowing(context, state.message);
            } else if (state is LoginSuccessState) {
              if(context.read<LoginCubit>().currentUser?.role == Role.admin) {
                pushReplacement(context, const HomeAdminView());
              }
              else {
                pushReplacement(context, const Root());
              }
            }
          },
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const CustomLoadingWidget();
            } else {
              return CustomFilledButton(
                onTap: () {
                  login(context);
                },
                text: 'Sign In',
              );
            }
          },
        ),
      ],
    );
  }

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<LoginCubit>().loginWithEmailAndPassword(_email, _password);
    }
  }
}
