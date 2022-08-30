// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class NewAdmin extends Admin {
  NewAdmin({required super.name, required super.profilePic, required super.uid});
  NewAdmin.fromAdmin(Admin other) : super(name: other.name, profilePic: other.profilePic, uid: other.uid);
}

class Admin {
  final String name;
  final String? profilePic;
  final String uid;

  Admin({required this.name, required this.profilePic, required this.uid});
}
