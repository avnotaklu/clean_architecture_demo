import 'package:aptcoder/core/injection_container.dart';
import 'package:aptcoder/features/admin/data/datasources/admin_remote_data_source.dart';
import 'package:aptcoder/features/admin/data/repositories/admin_repostiroy_impl.dart';
import 'package:aptcoder/features/admin/domain/repositories/admin_repository.dart';
import 'package:aptcoder/features/admin/domain/usecases/add_course.dart';
import 'package:aptcoder/features/admin/domain/usecases/get_admin_info.dart';

void adminInjectionContainer() {
  sl.registerLazySingleton(() => GetAdminInfo(sl()));
  sl.registerLazySingleton(() => AddCourse(sl()));
  sl.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl(sl()));
  sl.registerLazySingleton<AdminRemoteDataSource>(() => AdminRemoteDataSourceImpl(sl(), sl()));
}
