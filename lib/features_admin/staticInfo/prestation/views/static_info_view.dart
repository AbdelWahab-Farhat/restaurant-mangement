import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/features_admin/staticInfo/data/repo/static_info_repo_impl.dart';
import 'package:restaurant_management/features_admin/staticInfo/prestation/views/widgets/static_info_view_body.dart';

import '../viewModel/static_info_cubit.dart';

class StaticInfoView extends StatelessWidget {
  const StaticInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaticInfoCubit(StaticInfoRepoImpl()),
      child: const StaticInfoViewBody(),
    );
  }
}
