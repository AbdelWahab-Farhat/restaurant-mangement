part of 'employee_image_picker_cubit.dart';

@immutable
sealed class EmployeeImagePickerState {}

final class EmployeeImagePickerInitial extends EmployeeImagePickerState {}
final class EmployeeImagePickerSuccess extends EmployeeImagePickerState {}
final class EmployeeImagePickerFailure extends EmployeeImagePickerState {
  final String errMessage;
  EmployeeImagePickerFailure({required this.errMessage});
}
