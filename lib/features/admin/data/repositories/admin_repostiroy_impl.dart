import 'dart:typed_data';

import 'package:aptcoder/features/admin/data/core/exception.dart';
import 'package:aptcoder/features/admin/data/datasources/admin_remote_data_source.dart';
import 'package:aptcoder/features/admin/domain/core/failure.dart';
import 'package:aptcoder/features/admin/domain/entities/admin.dart';
import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/admin/domain/repositories/admin_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';

class AdminRepositoryImpl extends AdminRepository {
  final AdminRemoteDataSource dataSource;
  AdminRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, void>> addCourse(Course course) async {
    try {
      return Right((await dataSource.addCourse(course)));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Admin>> getAdminUser(String uid) async {
    try {
      return Right((await dataSource.getAdminUser(uid)));
    } on AdminNonExistantException catch (e) {
      return Left(AdminNonExistantFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Admin>> registerNewAdmin(Admin admin) async {
    try {
      return Right((await dataSource.registerNewAdmin(admin)));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, String>> putCourseImage(Uint8List data, String id, String filename) async {
    try {
      return Right(await dataSource.putCourseImage(data, id, filename));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, String>> putCourseResource(Uint8List data, String id, String filename) async {
    try {
      return Right(await dataSource.putCourseResource(data, id, filename));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
