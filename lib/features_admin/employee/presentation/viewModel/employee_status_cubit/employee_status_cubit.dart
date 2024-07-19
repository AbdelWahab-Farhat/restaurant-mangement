import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../../../models/employee.dart';

part 'employee_status_state.dart';

class EmployeeStatusCubit extends Cubit<EmployeeStatusState> {
  final List<Department> departments = Department.values;
  final List<Gender> genders = Gender.values;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Department pickedDepartment = Department.manager;
  Gender pickedGender = Gender.male;
  String? employeeName;
  String? phoneNumber;
  double? salary;
  int? workingHours;

  EmployeeStatusCubit() : super(EmployeeStatusInitial());

  void pickDepartment(Department department) {
    pickedDepartment = department;
  }

  void pickGender(Gender gender) {
    pickedGender = gender;
  }

  void initEmployeeName(String name) {
    employeeName = name;
  }

  void initPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  void initSalary(double salaryAvg) {
    salary = salaryAvg;
  }

  void initWorkingHours(int hours) {
    workingHours = hours;
  }

  bool validateAndSaveForm() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
