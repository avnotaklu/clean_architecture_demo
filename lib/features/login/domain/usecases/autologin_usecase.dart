import 'package:aptcoder/core/empty_params.dart';
import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/features/login/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AutoLoginUseCase extends UseCase<AuthUser, EmptyParams> {
  final AuthenticationRepository repository;

  AutoLoginUseCase(this.repository);
  @override
  Future<Either<Failure, AuthUser>> call(EmptyParams params) async {
    final userResult = await repository.getCurrentUser();
    return await userResult.fold((l) async => Left(l), (user) async {
      final usertype = await repository.getUserType(user);
      return await usertype.fold((l) async => Left(l), (type) async {
        return Right(AuthUser(user.displayName!, user.email!, false, type, user.uid, user.photoURL));
      });
    });
  }
}
