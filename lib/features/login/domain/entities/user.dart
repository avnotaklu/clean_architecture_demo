import 'package:equatable/equatable.dart';

enum Usertype { student, admin }

class AuthUser extends Equatable {
  final String displayName;
  final String email;
  final bool isNewUser;
  final Usertype type;
  final String uid;
  final String? profilePic;

  AuthUser(this.displayName, this.email, this.isNewUser, this.type,this.uid, this.profilePic);

  @override
  List<Object?> get props => [displayName, email, isNewUser, type];
}
