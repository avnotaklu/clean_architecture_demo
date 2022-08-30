import 'package:aptcoder/features/admin/di/injection_container.dart';
import 'package:aptcoder/features/courses/di/injection_container.dart';
import 'package:aptcoder/features/login/di/injection_container.dart';
import 'package:aptcoder/features/student_dashboard/di/injection_container.dart';
import 'package:aptcoder/features/student_profile/di/injection_container.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;
void init() {
  // Global dependencies
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);

  // Feature wise dependencies
  authenticationInjectionContainer();
  adminInjectionContainer();
  courseInjectionContainer();
  studentDashboardInjectionContainer();
  studentProfileInjectionContainer();
}
