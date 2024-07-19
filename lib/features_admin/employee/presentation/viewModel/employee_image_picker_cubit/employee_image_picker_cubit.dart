import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'employee_image_picker_state.dart';

class EmployeeImagePickerCubit extends Cubit<EmployeeImagePickerState> {
  EmployeeImagePickerCubit() : super(EmployeeImagePickerInitial());
  late String imageDownloadURL;
  File? imageFile;

  Future<void> initImageFile() async {
    final imagePicker = ImagePicker();
    final XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile == null) {
      return;
    }
    else {
      // init imageFile
      imageFile = File(xFile.path);
      emit(EmployeeImagePickerSuccess());
    }
  }
}
