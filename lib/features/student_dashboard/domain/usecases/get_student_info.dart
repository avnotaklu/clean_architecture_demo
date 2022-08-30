import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/features/student_dashboard/data/core/exception.dart';
import 'package:aptcoder/features/student_dashboard/domain/core/failures.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_dashboard/domain/repositories/student_repository.dart';
import 'package:dartz/dartz.dart';

class GetStudentInfo extends UseCase<Student, GetStudentParams> {
  final StudentRepository repository;
  GetStudentInfo(this.repository);
  @override
  Future<Either<Failure, Student>> call(GetStudentParams params) async {
    final user = params.user;

    final result = await repository.getStudentUser(params.user.uid);
    return result;
  }
}

class GetStudentParams {
  final AuthUser user;
  GetStudentParams(this.user);
}
