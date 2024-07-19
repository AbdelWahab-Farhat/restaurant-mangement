import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employee_date_picker_state.dart';

class EmployeeDatePickerCubit extends Cubit<EmployeeDatePickerState> {
  DateTime? dateOfBirth;
  EmployeeDatePickerCubit() : super(EmployeeDatePickerInitial());


  Future<void> initDateOfBirth(DateTime? employeeDateOfBirth) async {
    if (employeeDateOfBirth == null) {
      return;
    }
    dateOfBirth = employeeDateOfBirth;
    emit(EmployeeDatePickerSuccess());
  }
}
