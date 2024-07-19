String? validateName(String? value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(pattern);
  if (value?.isEmpty ?? true) {
    return "Name is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Name must be a-z and A-Z";
  }
  return null;
}
String? validateUserName(String? value) {
  if (value?.isEmpty ?? true) {
    return "Username is required";
  } else if (value!.length <= 2) {
    return "Username must be more than 3 characters";
  }
  return null;
}
String? validateMobile(String? value) {
  String pattern = r'(^\+?[0-9]*$)';
  RegExp regExp = RegExp(pattern);
  if (value?.isEmpty ?? true) {
    return "Mobile phone number is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Mobile phone number must contain only digits";
  }
  return null;
}
String? validatePassword(String? value) {
  if ((value?.length ?? 0) < 6) {
    return 'Password must be more than 5 characters';
  } else {
    return null;
  }
}
String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (password != confirmPassword) {
    return 'Password doesn\'t match';
  } else if (confirmPassword?.isEmpty ?? true) {
    return 'Confirm password is required';
  } else {
    return null;
  }
}
String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value ?? '')) {
    return 'Enter Valid Email';
  } else {
    return null;
  }
}
String? validateSalary(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a salary';
  }
  // Regular expression to match a positive number with optional decimal part
  final RegExp salaryRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  if (!salaryRegex.hasMatch(value)) {
    return 'Please enter a valid salary';
  }
  return null;
}
  String? validateWorkingHours(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter working hours';
    }
    // Regular expression to match a number between 0 and 24
    final RegExp workingHoursRegex = RegExp(r'^([0-9]|1[0-9]|2[0-4])$');
    if (!workingHoursRegex.hasMatch(value)) {
      return 'Please enter valid working hours (0-24)';
    }
    return null;
  }