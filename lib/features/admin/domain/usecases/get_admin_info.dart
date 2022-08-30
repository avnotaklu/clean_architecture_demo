import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/admin/domain/entities/admin.dart';
import 'package:aptcoder/features/admin/domain/repositories/admin_repository.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

class GetAdminInfo extends UseCase<Admin, GetAdminParams> {
  final AdminRepository repository;
  GetAdminInfo(this.repository);
  @override
  Future<Either<Failure, Admin>> call(GetAdminParams params) async {
    final user = params.user;

    if (params.user.isNewUser) {
      // Map User to Student Logic
      final result = await repository.registerNewAdmin(Admin(
        uid: user.uid,
        name: user.displayName,
        profilePic: user.profilePic,
      ));
      return result.fold((l) => Left(l), (r) {
        return Right(NewAdmin.fromAdmin(r));
      });
    } else {
      final result = await repository.getAdminUser(params.user.uid);
      return result;
    }
  }
}

class GetAdminParams {
  final AuthUser user;
  GetAdminParams(this.user);
}
