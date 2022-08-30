import 'package:aptcoder/core/injection_container.dart';
import 'package:aptcoder/features/login/data/datasources/remote/authentication_data_source.dart';
import 'package:aptcoder/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:aptcoder/features/login/domain/repositories/authentication_repository.dart';
import 'package:aptcoder/features/login/domain/usecases/add_student_info.dart';
import 'package:aptcoder/features/login/domain/usecases/authentication_login_use_case.dart';
import 'package:aptcoder/features/login/domain/usecases/autologin_usecase.dart';
import 'package:aptcoder/features/login/domain/usecases/logout_use_case.dart';

authenticationInjectionContainer() {
  sl.registerLazySingleton(() => AuthenticationLoginUseCase(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthenticationRemoteDataSourceImpl(sl(), sl(), sl()));
  sl.registerLazySingleton(() => AddStudentInfo(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => AutoLoginUseCase(sl()));
}
