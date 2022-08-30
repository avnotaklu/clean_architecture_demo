import 'package:aptcoder/core/error/app_exception.dart';
import 'package:aptcoder/features/login/data/core/exception.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/features/student_dashboard/data/models/student.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/core/constants.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserCredential> login();
  Future<Usertype> getUserType(creds);

  Future<StudentModel> addStudent(Student student);

  Future<void> logout();

  Future<User> getInitialUser();
  Future<Usertype> getCurrentUserType(User user);
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final Dio client;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRemoteDataSourceImpl(this.client, this._auth, this._googleSignIn);
  @override
  Future<UserCredential> login() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw UserNotFoundException();
    }
  }

  @override
  Future<Usertype> getUserType(creds) async {
    if (creds.user != null) {
      if (((await db.collection('admins').doc(creds.user!.uid).get())).exists) {
        return Usertype.admin;
      } else if ((await db.collection('students').doc(creds.user!.uid).get()).exists) {
        return Usertype.student;
      }
    }
    throw UserNotFoundException();
  }

  @override
  Future<StudentModel> addStudent(Student student) async {
    final model = StudentModel(
        uid: student.uid,
        name: student.name,
        course: student.course,
        institute: student.institute,
        sem: student.sem,
        rollNo: student.rollNo,
        profilePic: student.profilePic,
        lastViewedCourses: student.lastViewedCourses);
    await db.collection('students').doc(student.uid).set(model.toMap());
    return model;
  }

  @override
  Future<void> logout() async {
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<User> getInitialUser() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw UserNotFoundException();
    }
    return user;
  }

  @override
  Future<Usertype> getCurrentUserType(User user) async {
    final usertype = (await db.collection('admins').doc(user.uid).get()).exists
        ? Usertype.admin
        : (await db.collection('students').doc(user.uid).get()).exists
            ? Usertype.student
            : null;
    if (usertype == null) {
      throw InvalidUserException();
    }
    return usertype;
  }
}

