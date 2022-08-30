import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:dartz/dartz.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Course>>> getAllCourses();
}
