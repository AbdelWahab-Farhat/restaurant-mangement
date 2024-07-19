import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/buttons.dart';
import '../../../../../core/widgets/custom_TextformField.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../models/user/user.dart';
import '../../../../../utility/functions/validate_functions.dart';
import '../../../../../utility/helpers.dart';
import '../../../../../utility/size_config.dart';
import '../../viewModel/sign_up_cubit/signup_cubit.dart';
import '../login_view.dart';

class SignupSection extends StatelessWidget {
  SignupSection({super.key});

  final _formKey = GlobalKey<FormState>();

  late String _email;
  late String _userName;
  late String _confirmPassword;
  late String _password;
  late String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adding some padding for better UI
      child: Column(
        children: [
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
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  onSaved: (value) => _email = value!,
                  labelText: 'Email',
                  icon: Icons.email_outlined,
                  validator: validateEmail,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  onSaved: (value) => _phoneNumber = value!,
                  labelText: 'Mobile Number',
                  icon: Icons.phone,
                  validator: validateMobile,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  onSaved: (value) => _password = value!,
                  labelText: 'Password',
                  icon: Icons.lock_outline,
                  validator: validatePassword,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  onSaved: (value) => _confirmPassword = value!,
                  labelText: 'Confirm Password',
                  icon: Icons.lock_outline,
                  validator: (value) {
                    if (value != _password) {
                      return 'Passwords do not match';
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
              if (state is SignupFailureState) {
                snackBarShowing(context, state.message);
              } else if (state is SignupSuccessState) {
                snackBarShowing(context, state.message);
                pushAndRemoveUntil(context, const LoginView(), false);
              }
            },
            builder: (context, state) {
              if (state is SignupLoadingState) {
                return const CustomLoadingWidget();
              }
              return CustomFilledButton(
                onTap: () {
                  signup(context);
                },
                text: 'Sign Up',
              );
            },
          ),
        ],
      ),
    );
  }

  void signup(BuildContext context) {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      context.read<SignupCubit>().signupNewEmail(
        phoneNumber: _phoneNumber,
        email: _email,
        password: _password,
        userName: _userName,
        role: Role.customer,
      );
    }
  }

}
