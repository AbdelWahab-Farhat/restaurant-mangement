import 'package:flutter/material.dart';
import 'package:restaurant_management/features/auth/presentation/views/widgets/login_body.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return const LoginBody();
  }
}
