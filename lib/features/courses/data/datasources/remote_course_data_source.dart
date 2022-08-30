import 'package:aptcoder/features/courses/data/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RemoteCourseDataSource {
  Future<List<CourseModel>> getAllCourses();
}

class RemoteCourseDataSourceImpl extends RemoteCourseDataSource {
  final FirebaseFirestore db;

  RemoteCourseDataSourceImpl(this.db);
  @override
  Future<List<CourseModel>> getAllCourses() async {
    return (await db.collection('courses').get())
        .docs
        .map((e) => CourseModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
}
