import 'package:aptcoder/core/injection_container.dart';
import 'package:aptcoder/features/courses/data/datasources/remote_course_data_source.dart';
import 'package:aptcoder/features/courses/data/repositories/course_repository_impl.dart';
import 'package:aptcoder/features/courses/domain/repositories/course_repository.dart';
import 'package:aptcoder/features/courses/domain/usecases/get_all_courses_usecase.dart';

courseInjectionContainer() {
  sl.registerLazySingleton(() => GetAllCourses(sl()));
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(sl()));
  sl.registerLazySingleton<RemoteCourseDataSource>(() => RemoteCourseDataSourceImpl(sl()));
}
