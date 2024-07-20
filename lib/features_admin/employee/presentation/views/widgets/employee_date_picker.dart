import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewModel/employee_Date_picker_cubit/employee_date_picker_cubit.dart';
import 'employee_custom_text.dart';
import 'employee_textfield_date_picker.dart';

class EmployeeDatePicker extends StatelessWidget {
  const EmployeeDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EmployeeCustomText(title: 'Date Of Birth'),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1960, 1, 1),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now());
                context
                    .read<EmployeeDatePickerCubit>()
                    .initDateOfBirth(selectedDate);
              },
              child: const EmployeeTextFieldDatePicker(),
            ),
          ],
        );
  }
}

