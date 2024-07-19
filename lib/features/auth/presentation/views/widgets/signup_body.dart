import 'package:flutter/material.dart';
import 'package:restaurant_management/features/auth/presentation/views/widgets/signup_section.dart';
import 'package:restaurant_management/features/auth/presentation/views/widgets/title_section.dart';
import 'package:restaurant_management/features/auth/presentation/views/widgets/toggle_auth_view.dart';

import '../../../../../utility/helpers.dart';
import '../../../../../utility/size_config.dart';
import '../login_view.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key});

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
              const TitleSection(titleText: 'Sign Up', subTitleText: 'In Your Dream Restaurant.'),
              SizedBox(height: SizeConfig.space * 0.2),
              SignupSection(),
              ToggleAuthView(questionText: 'Have An Account?', viewText: 'Login', onTap: () => push(context, const LoginView()),),
              SizedBox(height: SizeConfig.space),
            ],
          ),
        ),
      ),
    );
  }
}
