import 'package:flutter/material.dart';
import 'package:restaurant_management/features/auth/presentation/views/widgets/title_section.dart';
import 'package:restaurant_management/features/auth/presentation/views/widgets/toggle_auth_view.dart';
import '../../../../../utility/helpers.dart';
import '../../../../../utility/size_config.dart';
import '../signup_view.dart';
import 'login_section.dart';


class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

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
              const TitleSection(
                titleText: 'Login',
                subTitleText:
                "Welcome to Wad Healthy Foods - Your Gateway to Nutritious Dining",
              ),
              LoginSection(),
              SizedBox(height: SizeConfig.space * 15),
              ToggleAuthView(
                questionText: "Don't Have Account ?",
                viewText: 'Sign Up',
                onTap: () => push(context,  const SignupView()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
