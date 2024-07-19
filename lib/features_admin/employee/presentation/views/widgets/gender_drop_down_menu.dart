import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/employee.dart';
import '../../viewModel/employee_status_cubit/employee_status_cubit.dart';
import 'employee_custom_text.dart';

class GenderDropDownMenu extends StatelessWidget {
  const GenderDropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EmployeeCustomText(title: 'Gender'),
        const SizedBox(height: 10,),
        DropdownButtonHideUnderline(
            child: DropdownMenu<Gender>(
              onSelected: (value) {
                context.read<EmployeeStatusCubit>().pickGender(value!);
              },
              initialSelection: context.read<EmployeeStatusCubit>().pickedGender,
              dropdownMenuEntries: context.read<EmployeeStatusCubit>().genders.map((gender) =>
                  DropdownMenuEntry<Gender>(
                      value: gender,
                      label: gender.name)
                ,).toList(),
            )
        ),
      ],
    );
  }
}
