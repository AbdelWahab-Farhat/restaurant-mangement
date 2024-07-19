import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utility/size_config.dart';
import '../../viewModel/employee_image_picker_cubit/employee_image_picker_cubit.dart';
import 'employee_image_box_info.dart';

class EmployeeImageBox extends StatelessWidget {
  const EmployeeImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<EmployeeImagePickerCubit, EmployeeImagePickerState>(
      builder: (context, state) {
        File? file = context.read<EmployeeImagePickerCubit>().imageFile;
        return GestureDetector(
          onTap: () async {
            await context.read<EmployeeImagePickerCubit>().initImageFile();
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            margin:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: SizeConfig.screenWidth / 2.2,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.grey)
                ]),
            child: file != null ? Image.file(file,fit: BoxFit.cover,) : const EmployeeImageBoxInfo(),
          ),
        );
      },
    );
  }
}

