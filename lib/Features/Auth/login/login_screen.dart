import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/Features/Profile/profile_cubit.dart';
import 'package:restaurant_management/Features/auth/login/login_cubit.dart';
import 'package:restaurant_management/Features/auth/signUp/signup_screen.dart';
import 'package:restaurant_management/Features/root/root_client.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/core/widgets/custom_TextformField.dart';
import 'package:restaurant_management/utility/helpers.dart';
import 'package:restaurant_management/utility/size_config.dart';
import 'package:restaurant_management/utility/styleing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user/user.dart';
import '../../home/menus/menu_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
            top: kToolbarHeight, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'Login',
                style: WidgetStyle.bigTextStyle(),
              ),
              SizedBox(
                height: SizeConfig.space,
              ),
              // Sub title
              const Text('Wlecome To Tripoli Restruent'),
              // Logo
              SizedBox(
                height: SizeConfig.space,
              ),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              SizedBox(height: SizeConfig.space * 5),
              // Forms
              Form(
                key: _formKey,
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
              SizedBox(height: SizeConfig.space * 15),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is LoginSuccessState) {
                    User? user = context.read<LoginCubit>().currentUser;
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      if (user!.role == Role.customer) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Root(),), (route) => false);
                        context.read<ProfileCubit>().loadUser();
                      }
                    });
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const CircularProgressIndicator(color: Colors.black),
                    );
                  } else {
                    return CustomFilledButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<LoginCubit>().loginWithEmailAndPassword(_email, _password);
                        }
                      },
                      text: 'Sign In',
                    );
                  }
                },
              ),
              SizedBox(height: SizeConfig.space * 0.8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have Account ?",
                    style: TextStyle(fontWeight: FontWeight.w400),),
                  SizedBox(width: SizeConfig.space * 0.5,),
                  GestureDetector(
                    onTap: () => push(context,const SignUpScreen()),
                    child: const Text("Sign Up", style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
