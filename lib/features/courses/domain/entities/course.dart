import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum CourseType { video, ppt, pdf }

class Course extends Equatable {
  final String name;
  late final String id;
  final CourseType type;
  final String resourceUrl;
  final String resourceName;
  final String imageUrl;

  Course({
    required this.name,
    required this.type,
    required this.resourceUrl,
    required this.imageUrl,
    required this.id,
    required this.resourceName,
  });

  @override
  List<Object?> get props => [name, id, type, resourceUrl, resourceName, imageUrl];
}
