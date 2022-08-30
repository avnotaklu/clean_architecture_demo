import 'dart:convert';

import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:flutter/foundation.dart';

@immutable
class CourseModel extends Course {
  CourseModel(
      {required super.name,
      required super.type,
      required super.resourceUrl,
      required super.imageUrl,
      required super.id,
      required super.resourceName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'type': type.name,
      'resourceUrl': resourceUrl,
      'resourceName': resourceName,
      'imageUrl': imageUrl,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      name: map['name'] as String,
      type: CourseType.values.byName(map['type'] as String),
      id: map['id'] as String,
      resourceUrl: map['resourceUrl'] as String,
      resourceName: map['resourceName'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
