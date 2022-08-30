import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/view_activity.dart';
import 'package:aptcoder/features/student_dashboard/domain/repositories/student_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ViewCourse extends UseCase<void, ViewCourseParams> {
  final StudentRepository repository;
  ViewCourse(this.repository);
  @override
  Future<Either<Failure, void>> call(ViewCourseParams params) async {
    return repository.viewCourse(
      params.student,
      ViewActivity(params.course.id, Timestamp.fromDate(DateTime.now())),
    );
  }
}

class ViewCourseParams {
  final Student student;
  final Course course;

  ViewCourseParams(this.student, this.course);
}
