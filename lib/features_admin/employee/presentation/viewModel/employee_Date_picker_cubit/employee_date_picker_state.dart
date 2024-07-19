part of 'employee_date_picker_cubit.dart';

@immutable
sealed class EmployeeDatePickerState {}

final class EmployeeDatePickerInitial extends EmployeeDatePickerState {}
final class EmployeeDatePickerSuccess extends EmployeeDatePickerState {}
