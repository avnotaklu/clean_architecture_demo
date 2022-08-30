import 'package:aptcoder/core/injection_container.dart';
import 'package:aptcoder/features/student_profile/data/datasources/profile_remote_data_source.dart';
import 'package:aptcoder/features/student_profile/data/repositories/profile_repository_impl.dart';
import 'package:aptcoder/features/student_profile/domain/repositories/profile_repository.dart';
import 'package:aptcoder/features/student_profile/domain/usecases/update_profile_info.dart';

studentProfileInjectionContainer() {
  sl.registerLazySingleton(() => UpdateProfileInfo(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(sl(), sl()));
}
