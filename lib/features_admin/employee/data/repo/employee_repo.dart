

import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../models/employee.dart';
import '../../../../utility/errors/failure.dart';

abstract class EmployeeRepo {
  Future<Either<Failure,String>> getImageDownloadLink(File file);
  Future<Either<Failure,void>> addEmployee(Employee employee);
}