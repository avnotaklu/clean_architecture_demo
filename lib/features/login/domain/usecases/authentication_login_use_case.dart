import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/login/domain/core/failure.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:aptcoder/features/login/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/empty_params.dart';

class AuthenticationLoginUseCase implements UseCase<AuthUser, AuthenticationParams> {
  final AuthenticationRepository repository;

  AuthenticationLoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthUser>> call(AuthenticationParams params) async {
    final creds = await repository.login();
    final user = await creds.fold<Future<Either<Failure, AuthUser>>>((Failure l) => Future.value(Left(l)),
        (UserCredential user) async {
      if (user.additionalUserInfo != null) {
        if (user.additionalUserInfo!.isNewUser == false) {
          final type = await repository.getUsertype(user);

          return type.fold<Either<Failure, AuthUser>>((l) => Left(l), (type) {
            if (type == Usertype.admin && params.type == Usertype.student) {
              return Left(IncorrectAccountRequested(Usertype.student, Usertype.admin));
            }
            if (type == Usertype.student && params.type == Usertype.admin) {
              return Left(IncorrectAccountRequested(Usertype.admin, Usertype.student));
            }
            return Right(AuthUser(user.user!.displayName!, user.user!.email!, user.additionalUserInfo!.isNewUser, type,
                user.user!.uid, user.user!.photoURL));
          });
        } else {
          return Right(AuthUser(user.user!.displayName!, user.user!.email!, user.additionalUserInfo!.isNewUser,
              params.type, user.user!.uid, user.user!.photoURL));
        }
      } else {
        return Left(InvalidUser());
      }
    });
    return user;
  }
}

class AuthenticationParams {
  final Usertype type;
  AuthenticationParams(this.type);
}
