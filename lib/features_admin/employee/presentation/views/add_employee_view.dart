import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/employee_repo_impl.dart';
import '../viewModel/add_employee/add_employee_cubit.dart';
import '../viewModel/employee_Date_picker_cubit/employee_date_picker_cubit.dart';
import '../viewModel/employee_image_picker_cubit/employee_image_picker_cubit.dart';
import '../viewModel/employee_status_cubit/employee_status_cubit.dart';
import 'widgets/add_employee_view_body.dart';



class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EmployeeImagePickerCubit(),),
        BlocProvider(create: (context) => EmployeeDatePickerCubit(),),
        BlocProvider(create: (context) => EmployeeStatusCubit(),),
        BlocProvider(create: (context) => AddEmployeeCubit(employeeRepo: EmployeeRepoImpl()),)
      ],
      child: const AddEmployeeViewBody(),
    );
  }
}
