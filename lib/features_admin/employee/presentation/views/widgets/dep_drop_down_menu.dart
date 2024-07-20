import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/employee.dart';
import '../../viewModel/employee_status_cubit/employee_status_cubit.dart';
import 'employee_custom_text.dart';

class DepDropDownMenu extends StatelessWidget {
  const DepDropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EmployeeCustomText(title: 'Department'),
        const SizedBox(height: 10,),
        DropdownButtonHideUnderline(
            child: DropdownMenu<Department>(
              onSelected: (value) {
                context.read<EmployeeStatusCubit>().pickDepartment(value!);
              },
              initialSelection: context.read<EmployeeStatusCubit>().pickedDepartment,
              dropdownMenuEntries: context.read<EmployeeStatusCubit>().departments.map((dep) =>
                  DropdownMenuEntry<Department>(
                      value: dep,
                      label: dep.name)
                ,).toList(),
            )
        ),
      ],
    );
  }
}
