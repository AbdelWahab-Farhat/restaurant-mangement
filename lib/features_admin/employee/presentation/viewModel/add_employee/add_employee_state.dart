part of 'add_employee_cubit.dart';

@immutable
sealed class AddEmployeeState {}

final class AddEmployeeInitial extends AddEmployeeState {}
final class AddEmployeeLoading extends AddEmployeeState {}
final class AddEmployeeFailure extends AddEmployeeState {
  final String errMessage;

  AddEmployeeFailure({required this.errMessage});
}
final class AddEmployeeSuccess extends AddEmployeeState {
  final String successMessage;

  AddEmployeeSuccess({required this.successMessage});

}

