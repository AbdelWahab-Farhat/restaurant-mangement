import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/Features/auth/login/login_screen.dart';
import 'package:restaurant_management/Features/auth/signup/signup_cubit.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/core/widgets/custom_TextformField.dart';
import 'package:restaurant_management/utility/helpers.dart';
import 'package:restaurant_management/utility/size_config.dart';
import 'package:restaurant_management/utility/styleing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _userName;
  late String _confirmPassword;
  late String _password;
  late String _phoneNumber;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'Sign Up',
                style: WidgetStyle.bigTextStyle(),
              ),
              SizedBox(
                height: SizeConfig.space,
              ),
              // Sub title
              const Text('Welcome To Tripoli Restaurant'),
              // Logo
              SizedBox(
                height: SizeConfig.space,
              ),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              SizedBox(height: SizeConfig.space * 3),
              // Forms
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: 'UserName',
                      onSaved: (value) {
                        _userName = value!;
                      },
                      icon: Icons.person_outline,
                      validator: validateUserName,
                    ),
                    SizedBox(
                      height: SizeConfig.space,
                    ),
                    CustomTextFormField(
                      onSaved: (value) => _email = value!,
                      labelText: 'Email',
                      icon: Icons.email_outlined,
                      validator: validateEmail,
                    ),
                    SizedBox(
                      height: SizeConfig.space,
                    ),
                    CustomTextFormField(
                      onSaved: (value) => _phoneNumber = value!,
                      labelText: 'mobile Number',
                      icon: Icons.phone,
                      validator: validateMobile,
                    ),
                    SizedBox(
                      height: SizeConfig.space ,
                    ),
                    CustomTextFormField(
                      onSaved: (value) => _password = value!,
                      labelText: 'Password',
                      icon: Icons.lock_outline,
                      validator: validatePassword,
                      isPassword: true,
                    ),
                    SizedBox(
                      height: SizeConfig.space,
                    ),
                    CustomTextFormField(
                      onSaved: (value) => _confirmPassword = value!,
                      labelText: 'Confirm Password',
                      icon: Icons.lock_outline,
                      validator: (value) {
                        if (value != _password) {
                          return 'Passwords doesnt not match';
                        }
                        return null;
                      },
                      isPassword: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.space * 0.5),
              BlocConsumer<SignupCubit, SignupState>(
                listener: (context, state) {
                  if (state is SignupErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  } else if (state is SignupSuccessState) {
                    snackBarShowing(context, state.message);
                    pushAndRemoveUntil(context, const LoginScreen(), false);
                  }
                },
                builder: (context, state) {
                  if (state is SignupLoadingState) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child:
                          const CircularProgressIndicator(color: Colors.black),
                    );
                  }
                  return CustomFilledButton(
                    onTap: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        context.read<SignupCubit>().signupNewEmail(
                              _phoneNumber,
                              _email,
                              _password,
                              _userName,
                              Role.customer,
                            );
                      }
                    },
                    text: 'Sign Up',
                  );
                },
              ),
              SizedBox(height: SizeConfig.space * 0.8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Have Account ?",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: SizeConfig.space * 0.5),
                  GestureDetector(
                    onTap: () => push(context, const LoginScreen()),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
