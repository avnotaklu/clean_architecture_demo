import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/courses/data/datasources/remote_course_data_source.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:aptcoder/features/courses/domain/repositories/course_repository.dart';
import 'package:dartz/dartz.dart';

class CourseRepositoryImpl extends CourseRepository {
  final RemoteCourseDataSource dataSource;

  CourseRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<Course>>> getAllCourses() async {
    try {
      return Right(await dataSource.getAllCourses());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}