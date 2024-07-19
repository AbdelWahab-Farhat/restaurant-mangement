

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:restaurant_management/models/employee.dart';
import 'package:restaurant_management/utility/errors/failure.dart';

import 'employee_repo.dart';

class EmployeeRepoImpl extends EmployeeRepo {
  @override
  Future<Either<Failure, String>> getImageDownloadLink(File file) async {
    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      final storageReference = FirebaseStorage.instance.ref().child('images/${file.uri.pathSegments.last}');

      // Upload the file to Firebase Storage
      final uploadTask = storageReference.putFile(file);

      // Wait for the upload to complete
      final taskSnapshot = await uploadTask;

      // Get the download URL
      final downloadURL = await taskSnapshot.ref.getDownloadURL();

      return right(downloadURL);
    } catch (e) {
      return left(FailureService(errMessage: 'Failed to upload image: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> addEmployee(Employee employee) async {
    try {
      await FirebaseFirestore.instance.collection('employees').doc(employee.employeeID).set(employee.toJson());
      return right(null);
    } on FirebaseException catch (e) {
      return left(FailureService(errMessage: e.code));
    }
  }
}