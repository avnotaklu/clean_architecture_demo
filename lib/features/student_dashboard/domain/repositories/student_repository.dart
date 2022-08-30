import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/view_activity.dart';
import 'package:dartz/dartz.dart';

abstract class StudentRepository {
  Future<Either<Failure, Student>> getStudentUser(String id);
  Future<Either<Failure, List<Course>>> getStudentLastViewedCourses(List<ViewActivity> activities);
  Future<Either<Failure, void>> viewCourse(Student student, ViewActivity viewActivity);
}
