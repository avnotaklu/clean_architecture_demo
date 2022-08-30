import 'package:aptcoder/core/empty_params.dart';
import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/login/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase extends UseCase<void, EmptyParams> {
  final AuthenticationRepository repository;

  LogoutUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(EmptyParams params) {
    return repository.logout();
  }
}
