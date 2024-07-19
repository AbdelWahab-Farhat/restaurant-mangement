import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_management/utility/errors/failure.dart';

import '../../../../../models/employee.dart';
import '../../../data/repo/employee_repo.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final EmployeeRepo employeeRepo;
  AddEmployeeCubit({required this.employeeRepo}) : super(AddEmployeeInitial());

  Future<void> addEmployee({
    required File file,
    required String employeeID,
    required String employeeName,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required Department employeeDepartment,
    required Gender employeeGender,
    required double employeeSalary,
    required int employeeWorkingHours,
  }) async {
    emit(AddEmployeeLoading());
    String? imgDownloadLink;
    var result = await employeeRepo.getImageDownloadLink(file);
    result.fold(
      (failure) => emit(AddEmployeeFailure(errMessage: failure.errMessage)),
      (downloadLink) => imgDownloadLink = downloadLink,
    );
    if (imgDownloadLink != null) {
      final employee = Employee(
          employeeImgURL: imgDownloadLink!,
          dateOfBirth: dateOfBirth,
          employeeDepartment: employeeDepartment,
          employeeID: employeeID,
          employeeGender: employeeGender,
          employeeName: employeeName,
          employeeSalary: employeeSalary,
          phoneNumber: phoneNumber,
          employeeWorkingHours: employeeWorkingHours);
      var result = await employeeRepo.addEmployee(employee);
      result.fold(
        (failure) => emit(AddEmployeeFailure(errMessage: failure.errMessage)),
        (r) => emit(AddEmployeeSuccess(successMessage: 'Added successfully')),
      );
    }
  }
}
