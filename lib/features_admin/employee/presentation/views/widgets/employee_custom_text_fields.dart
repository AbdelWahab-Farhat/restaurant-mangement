import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management/features_admin/employee/presentation/views/widgets/employee_custom_text.dart';
import '../../../../../utility/functions/validate_functions.dart';
import '../../viewModel/employee_status_cubit/employee_status_cubit.dart';

class EmployeeTextFields extends StatelessWidget {
  const EmployeeTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<EmployeeStatusCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: EmployeeCustomText(title: 'Name'),
          ),
          TextFormField(
            onSaved: (name) =>
                context.read<EmployeeStatusCubit>().initEmployeeName(name!),
            validator: validateName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: EmployeeCustomText(title: 'Phone Number'),
          ),
          TextFormField(
            onSaved: (phoneNumber) => context
                .read<EmployeeStatusCubit>()
                .initPhoneNumber(phoneNumber!),
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: false),
            validator: validateMobile,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: EmployeeCustomText(title: 'Salary'),
          ),
          TextFormField(
            onSaved: (salary) => context
                .read<EmployeeStatusCubit>()
                .initSalary(double.parse(salary!)),
            validator: validateSalary,
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: EmployeeCustomText(title: 'Working Hours'),
          ),
          TextFormField(
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: false),
            onSaved: (hours) =>
                context.read<EmployeeStatusCubit>().initWorkingHours(int.parse(hours!)),
            validator: validateWorkingHours,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
