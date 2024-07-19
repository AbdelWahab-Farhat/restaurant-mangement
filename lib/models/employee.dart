class Employee {
  String employeeImgURL;
  String employeeID;
  String employeeName;
  String phoneNumber;
  DateTime dateOfBirth;
  Department employeeDepartment;
  Gender employeeGender;
  double employeeSalary;
  int employeeWorkingHours;

  Employee({
    required this.employeeImgURL,
    required this.dateOfBirth,
    required this.employeeDepartment,
    required this.employeeID,
    required this.employeeGender,
    required this.employeeName,
    required this.employeeSalary,
    required this.phoneNumber,
    required this.employeeWorkingHours,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeImgURL: json['employeeImgURL'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      employeeDepartment: departmentFromString(json['employeeDepartment']),
      employeeID: json['employeeID'],
      employeeGender: genderFromString(json['employeeGender']),
      employeeName: json['employeeName'],
      employeeSalary: json['employeeSalary'].toDouble(),
      phoneNumber: json['phoneNumber'],
      employeeWorkingHours: json['employeeWorkingHours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeImgURL': employeeImgURL,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'employeeDepartment': departmentToString(employeeDepartment),
      'employeeID': employeeID,
      'employeeGender': genderToString(employeeGender),
      'employeeName': employeeName,
      'employeeSalary': employeeSalary,
      'phoneNumber': phoneNumber,
      'employeeWorkingHours': employeeWorkingHours,
    };
  }
}

enum Gender {
  male,
  female
}

String genderToString(Gender gender) {
  return gender.toString().split('.').last;
}

Gender genderFromString(String genderString) {
  return Gender.values.firstWhere(
        (e) => e.toString().split('.').last == genderString,
    orElse: () => Gender.male, // Default value
  );
}

enum Department {
  chef,
  manager,
  garson,
}

String departmentToString(Department department) {
  return department.toString().split('.').last;
}

Department departmentFromString(String departmentString) {
  return Department.values.firstWhere(
        (e) => e.toString().split('.').last == departmentString,
    orElse: () => Department.chef, // Default value
  );
}

enum Performance {
  excellent,
  good,
  bad,
}

String performanceToString(Performance performance) {
  return performance.toString().split('.').last;
}

Performance performanceFromString(String performanceString) {
  return Performance.values.firstWhere(
        (e) => e.toString().split('.').last == performanceString,
    orElse: () => Performance.excellent, // Default value
  );
}
