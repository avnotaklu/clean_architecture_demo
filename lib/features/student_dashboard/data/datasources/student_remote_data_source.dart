import 'package:aptcoder/features/courses/data/models/course.dart';
import 'package:aptcoder/features/student_dashboard/data/models/student.dart';
import 'package:aptcoder/features/student_dashboard/data/models/view_activity.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/view_activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class StudentRemoteDataSource {
  Future<StudentModel> fetchStudent(String id);
  Future<List<CourseModel>> getStudentLastViewedCourses(List<ViewActivity> activities);
  Future<void> addCourse(Student student, ViewActivity course);
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final FirebaseFirestore db;

  StudentRemoteDataSourceImpl(this.db);

  @override
  Future<void> addCourse(Student student, ViewActivity viewActivity) async {
    final collectionPath = 'students';
    if (student.lastViewedCourses.any(((element) => element.resource == viewActivity.resource))) {
      final matchingViewActivity =
          (student.lastViewedCourses.firstWhere(((element) => element.resource == viewActivity.resource)));

      await db.collection(collectionPath).doc(student.uid).update({
        'lastViewedCourses': FieldValue.arrayRemove([
          ViewActivityModel(
            matchingViewActivity.resource,
            matchingViewActivity.time,
          ).toMap()
        ]),
      });

      await db.collection(collectionPath).doc(student.uid).update({
        'lastViewedCourses':
            FieldValue.arrayUnion([ViewActivityModel(viewActivity.resource, viewActivity.time).toMap()]),
      });
    } else {
      await db.collection(collectionPath).doc(student.uid).update({
        'lastViewedCourses': FieldValue.arrayUnion([
          ViewActivityModel(
            viewActivity.resource,
            viewActivity.time,
          ).toMap()
        ]),
      });
    }
  }

  @override
  Future<StudentModel> fetchStudent(String id) async {
    final modelData = await db.collection('students').doc(id).get();
    return StudentModel.fromMap(modelData.data() as Map<String, dynamic>);
  }

  @override
  Future<List<CourseModel>> getStudentLastViewedCourses(List<ViewActivity> activities) async {
    return await Future.wait(activities.map((e) async =>
        CourseModel.fromMap((await db.collection('courses').doc((e.resource)).get()).data() as Map<String, dynamic>)));
  }
}
