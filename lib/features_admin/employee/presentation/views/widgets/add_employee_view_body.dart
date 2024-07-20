
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../../../core/widgets/custom_appbar.dart';
import 'add_employee_button.dart';
import 'dep_drop_down_menu.dart';
import 'employee_custom_text_fields.dart';
import 'employee_date_picker.dart';
import 'employee_image_box.dart';
import 'gender_drop_down_menu.dart';

class AddEmployeeViewBody extends StatefulWidget {
  const AddEmployeeViewBody({super.key});

  @override
  State<AddEmployeeViewBody> createState() => _AddEmployeeViewBodyState();
}

class _AddEmployeeViewBodyState extends State<AddEmployeeViewBody> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(
        title: 'Add Employee',
        isCentred: true,
        hasBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EmployeeImageBox(),
              SizedBox(
                height: 10,
              ),
              EmployeeDatePicker(),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [DepDropDownMenu(), Spacer(), GenderDropDownMenu()],
              ),
              EmployeeTextFields(),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: AddEmployeeButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

