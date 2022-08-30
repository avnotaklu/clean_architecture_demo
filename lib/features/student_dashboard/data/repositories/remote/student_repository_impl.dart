import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/student_dashboard/data/core/exception.dart';
import 'package:aptcoder/features/student_dashboard/data/datasources/student_remote_data_source.dart';
import 'package:aptcoder/features/student_dashboard/domain/core/failures.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/view_activity.dart';
import 'package:aptcoder/features/student_dashboard/domain/repositories/student_repository.dart';
import 'package:dartz/dartz.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource dataSource;
  StudentRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Course>>> getStudentLastViewedCourses(List<ViewActivity> activities) async {
    try {
      return Right((await dataSource.getStudentLastViewedCourses(activities)));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Student>> getStudentUser(String id) async {
    try {
      return Right((await dataSource.fetchStudent(id)));
    } on StudentNonExistantException catch (e) {
      return Left(StudentNonExistantFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }


  @override
  Future<Either<Failure, void>> viewCourse(Student student, ViewActivity viewActivity) async {
    try {
      return Right(await dataSource.addCourse(student, viewActivity));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
