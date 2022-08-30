import 'dart:typed_data';

import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/admin/domain/entities/admin.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepository {
  Future<Either<Failure, Admin>> registerNewAdmin(Admin admin);
  Future<Either<Failure, Admin>> getAdminUser(String uid);
  Future<Either<Failure, void>> addCourse(Course course);
  Future<Either<Failure, String>> putCourseImage(Uint8List data, String id, String filename);
  Future<Either<Failure, String>> putCourseResource(Uint8List data, String id, String filename);
}
