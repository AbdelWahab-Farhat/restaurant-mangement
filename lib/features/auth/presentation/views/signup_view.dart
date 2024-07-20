import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wid_healthy_food_restaurant/Features/auth/data/repo/auth_repo_impl.dart';
import 'package:wid_healthy_food_restaurant/Features/auth/presentation/viewModel/sign_up_cubit/signup_cubit.dart';

import 'widgets/signup_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(AuthRepoImpl(
          auth: FirebaseAuth.instance, store: FirebaseFirestore.instance)),
      child: const SignupBody(),
    );
  }
}
