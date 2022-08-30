import 'dart:ffi';
import 'dart:typed_data';

import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_profile/data/datasources/profile_remote_data_source.dart';
import 'package:aptcoder/features/student_profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, Student>> updateStudentProfile(Student student) async {
    try {
      await dataSource.updateStudentProfile(student);
      return Right(student);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadStudentProfilePic(Student student, Uint8List profilePic) async {
    try {
      return Right(await dataSource.uploadStudentProfilePic(student, profilePic));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
