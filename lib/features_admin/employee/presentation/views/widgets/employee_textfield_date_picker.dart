import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utility/app_style.dart';
import '../../../../../utility/constents.dart';
import '../../../../../utility/helpers.dart';
import '../../viewModel/employee_Date_picker_cubit/employee_date_picker_cubit.dart';


class EmployeeTextFieldDatePicker extends StatelessWidget {
  const EmployeeTextFieldDatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeDatePickerCubit, EmployeeDatePickerState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
              hintText: formatDate(
                  context
                      .read<EmployeeDatePickerCubit>()
                      .dateOfBirth) ??
                  'YYYY/MM/DD',
              hintStyle: AppStyle.textBodySmall
                  .copyWith(color: Colors.grey, fontSize: 16),
              enabled: false,
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDarkPrimaryColor))),
        );
      },
    );
  }
}
