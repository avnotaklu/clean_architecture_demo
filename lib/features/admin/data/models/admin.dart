// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:aptcoder/features/admin/domain/entities/admin.dart';

class AdminModel extends Admin {
  AdminModel({required super.name, required super.profilePic, required super.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
    );
  }
}
