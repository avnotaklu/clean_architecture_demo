import 'dart:typed_data';

import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileInfo extends UseCase<Student, UpdateStudentParams> {
  final ProfileRepository repository;

  UpdateProfileInfo(this.repository);
  @override
  Future<Either<Failure, Student>> call(UpdateStudentParams params) async {
    if (params.profilePic != null) {
      final picResult = await repository.uploadStudentProfilePic(params.student, params.profilePic!);
      return await picResult.fold((l) async => Left(l), (r) async {
        final newstudent = params.student.copyWith(profilePic: r);
        return await repository.updateStudentProfile(newstudent);
      });
    } else {
      return await repository.updateStudentProfile(params.student);
    }
  }
}

class UpdateStudentParams {
  final Student student;
  final Uint8List? profilePic;
  UpdateStudentParams(this.student, this.profilePic);
}
