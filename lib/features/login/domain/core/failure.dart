import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/features/login/domain/entities/user.dart';

class InvalidUser extends Failure {
  InvalidUser() : super([]);
}

class IncorrectAccountRequested extends Failure {
  final Usertype requested;
  final Usertype exists;
  IncorrectAccountRequested(this.requested, this.exists) : super([requested, exists]);
}

class UserNotFound extends Failure {
  UserNotFound() : super([]);
}
