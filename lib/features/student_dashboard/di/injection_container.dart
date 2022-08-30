import 'package:aptcoder/core/injection_container.dart';
import 'package:aptcoder/features/student_dashboard/data/datasources/student_remote_data_source.dart';
import 'package:aptcoder/features/student_dashboard/data/repositories/remote/student_repository_impl.dart';
import 'package:aptcoder/features/student_dashboard/domain/repositories/student_repository.dart';
import 'package:aptcoder/features/student_dashboard/domain/usecases/get_student_info.dart';
import 'package:aptcoder/features/student_dashboard/domain/usecases/get_student_last_courses.dart';
import 'package:aptcoder/features/student_dashboard/domain/usecases/view_course.dart';

studentDashboardInjectionContainer() {
  sl.registerLazySingleton(() => GetStudentInfo(sl()));
  sl.registerLazySingleton(() => GetStudentLastCourses(sl()));
  sl.registerLazySingleton(() => ViewCourse(sl()));
  sl.registerLazySingleton<StudentRepository>(() => StudentRepositoryImpl(sl()));
  sl.registerLazySingleton<StudentRemoteDataSource>(() => StudentRemoteDataSourceImpl(sl()));
}
