import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:aptcoder/features/admin/data/models/admin.dart';
import 'package:aptcoder/features/admin/domain/entities/admin.dart';
import 'package:aptcoder/features/courses/data/models/course.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AdminRemoteDataSource {
  Future<AdminModel> registerNewAdmin(Admin admin);
  Future<AdminModel> getAdminUser(String uid);
  Future<void> addCourse(Course course);
  Future<String> putCourseResource(Uint8List data, String id, String filename);
  Future<String> putCourseImage(Uint8List data, String id, String filename);
}

class AdminRemoteDataSourceImpl extends AdminRemoteDataSource {
  final FirebaseFirestore db;
  final FirebaseStorage storage;

  AdminRemoteDataSourceImpl(this.db, this.storage);
  @override
  Future<void> addCourse(Course course) async {
    db.collection('courses').doc(course.id).set(CourseModel(
            name: course.name,
            type: course.type,
            resourceUrl: course.resourceUrl,
            imageUrl: course.imageUrl,
            id: course.id,
            resourceName: course.resourceName)
        .toMap());
  }

  @override
  Future<AdminModel> getAdminUser(String uid) async {
    return AdminModel.fromMap((await db.collection('admins').doc(uid).get()).data() as Map<String, dynamic>);
  }

  @override
  Future<AdminModel> registerNewAdmin(Admin admin) async {
    final adminModel = AdminModel(name: admin.name, profilePic: admin.profilePic, uid: admin.uid);
    await db.collection('admins').doc(admin.uid).set(adminModel.toMap());
    return adminModel;
  }

  @override
  Future<String> putCourseImage(Uint8List data, String id, String filename) async {
    var ref = storage.ref('course/$id/image/$filename');
    await ref.putData(data);
    return ref.getDownloadURL();
  }

  @override
  Future<String> putCourseResource(Uint8List resource, String id, String filename) async {
    var ref = storage.ref('course/$id/resource/$filename');
    await ref.putData(resource);
    return ref.getDownloadURL();
  }
}
