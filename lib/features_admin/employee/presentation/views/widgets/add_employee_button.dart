import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/widgets/buttons.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../utility/helpers.dart';
import '../../viewModel/add_employee/add_employee_cubit.dart';
import '../../viewModel/employee_Date_picker_cubit/employee_date_picker_cubit.dart';
import '../../viewModel/employee_image_picker_cubit/employee_image_picker_cubit.dart';
import '../../viewModel/employee_status_cubit/employee_status_cubit.dart';


class AddEmployeeButton extends StatelessWidget {
  const AddEmployeeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
      listener: (context, state) {
        if (state is AddEmployeeSuccess) {
          snackBarShowing(context, state.successMessage);
          Navigator.pop(context);
        }
        else if (state is AddEmployeeFailure) {
          snackBarShowing(context, state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is AddEmployeeLoading) {
          return const CustomLoadingWidget();
        }
        return CustomFilledButton(
            onTap: () async {
              final EmployeeStatusCubit cubitStatus =
              context.read<EmployeeStatusCubit>();
              final EmployeeDatePickerCubit cubitDatePicker =
              context.read<EmployeeDatePickerCubit>();
              final EmployeeImagePickerCubit cubitImagePicker =
              context.read<EmployeeImagePickerCubit>();
              final AddEmployeeCubit addEmployeeCubit =
              context.read<AddEmployeeCubit>();
              if (cubitImagePicker.imageFile == null) {
                snackBarShowing(
                    context, 'Please Enter Employee Image');
                return;
              } else if (cubitDatePicker.dateOfBirth == null) {
                snackBarShowing(
                    context, 'Please Enter Date Of Birth');
                return;
              }
              if (cubitStatus.validateAndSaveForm()) {
                await addEmployeeCubit.addEmployee(
                    file: cubitImagePicker.imageFile!,
                    employeeID: const Uuid().v8(),
                    phoneNumber: cubitStatus.phoneNumber!,
                    employeeName: cubitStatus.employeeName!,
                    dateOfBirth: cubitDatePicker.dateOfBirth!,
                    employeeDepartment:
                    cubitStatus.pickedDepartment,
                    employeeGender: cubitStatus.pickedGender,
                    employeeSalary: cubitStatus.salary!,
                    employeeWorkingHours:
                    cubitStatus.workingHours!);
              }
            },
            text: 'confirm');
      },
    );
  }
}
