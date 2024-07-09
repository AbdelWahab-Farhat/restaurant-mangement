import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/Features/Profile/profile_cubit.dart';
import 'package:restaurant_management/core/widgets/buttons.dart';
import 'package:restaurant_management/core/widgets/custom_TextformField.dart';
import 'package:restaurant_management/core/widgets/custom_appbar.dart';
import 'package:restaurant_management/models/user/user.dart';
import 'package:restaurant_management/utility/constents.dart';

import '../../../models/user/customer.dart';
import '../../../utility/helpers.dart';
import '../../../utility/size_config.dart';

class EditProfileScreen extends StatefulWidget {
  final Customer customer;

  const EditProfileScreen({super.key, required this.customer});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _userName;
  late String _password;
  late String _confirmPassword;
  late String _phoneNumber;

  @override
  void initState() {
    _userName = widget.customer.userName;
    _password = widget.customer.password;
    _phoneNumber = widget.customer.phoneNumber;
    _confirmPassword = widget.customer.password;
    super.initState();
  }

  @override
  void _submitForm() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      Customer cust = Customer(
          userID: widget.customer.userID,
          userName: _userName,
          password: _password,
          role: Role.customer,
          customerID: widget.customer.customerID,
          phoneNumber: _phoneNumber);

      context.read<ProfileCubit>().updateUser(cust, widget.customer.password);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Edit Profile', isCentred: false,hasBackButton: true,),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: _userName,
                    labelText: 'UserName',
                    onSaved: (value) {
                      if (value == null || value.isEmpty) {
                        return;
                      }
                      else {
                        _userName = value!;
                      }
                    },
                    icon: Icons.person_outline,
                    validator: (_) {
                      return validateUserName(_userName);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.space,
                  ),
                  CustomTextFormField(
                    hintText: widget.customer.phoneNumber,
                    onSaved: (value) {
                      if (value == null || value.isEmpty) {
                        return;
                      }
                      else {
                        _phoneNumber = value!;
                      }
                    },
                    labelText: 'Mobile Number',
                    icon: Icons.phone,
                    validator: (_) {
                      return validateMobile(_phoneNumber);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.space,
                  ),
                  CustomTextFormField(
                    hintText:
                        '******', // Don't show the actual password for security reasons
                    onSaved: (value) {
                      if (value == null || value.isEmpty) {
                        return;
                      }
                      else {
                        _password = value!;
                      }
                    },
                    labelText: 'Password',
                    icon: Icons.lock_outline,
                    validator: (_) {
                      return validatePassword(_password);
                    },
                    isPassword: true,
                  ),
                  SizedBox(
                    height: SizeConfig.space,
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      if (value == null || value.isEmpty) {
                        return;
                      }
                      else {
                        _confirmPassword = value!;
                      }
                    },
                    labelText: 'Confirm Password',
                    icon: Icons.lock_outline,
                    validator: (value) {
                      if (_confirmPassword != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    isPassword: true,
                  ),
                  SizedBox(
                    height: SizeConfig.space * 2,
                  ),
                  BlocListener<ProfileCubit, ProfileState>(
                    listener: (context, state) async {
                      if (state is ProfileError) {
                        snackBarShowing(context, state.message);
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                              context
                            .read<ProfileCubit>()
                            .emit(ProfileSuccess(customer: widget.customer));
                      }
                    },
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: kDarkPrimaryColor,
                            ),
                          );
                        } else {
                          return CustomFilledButton(
                            text: 'Save Changes',
                            onTap: _submitForm,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String? validatePasswordgg(String? value) {
    'testing';
    print(value);
    return null;
  }
}
