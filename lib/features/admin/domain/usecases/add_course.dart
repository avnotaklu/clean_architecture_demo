import 'dart:typed_data';

import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/usecases/usecase.dart';
import 'package:aptcoder/features/admin/domain/repositories/admin_repository.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class AddCourse extends UseCase<void, AddCourseParams> {
  final AdminRepository repository;
  AddCourse(this.repository);
  @override
  Future<Either<Failure, void>> call(AddCourseParams params) async {
    // If any field is null Fail
    if (params.image == null) return Left(NullFailure());
    if (params.resource == null) return Left(NullFailure());
    if (params.name == null) return Left(NullFailure());
    if (params.type == null) return Left(NullFailure());
    if (params.imageName == null) return Left(NullFailure());
    if (params.filename == null) return Left(NullFailure());
    final id = Uuid().v1();

    final image = await repository.putCourseImage(
      params.image!,
      id,
      params.imageName!,
    );
    final resource = await repository.putCourseImage(params.resource!, id, params.filename!);
    return await image.fold((l) async => Left(l), (image) async {
      return resource.fold((l) async => Left(l), (resource) async {
        final course = Course(
            name: params.name!,
            type: params.type!,
            resourceUrl: resource,
            imageUrl: image,
            resourceName: params.filename!,
            id: Uuid().v1());

        return await repository.addCourse(course);
      });
    });
  }
}

class AddCourseParams {
  final CourseType? type;
  final Uint8List? resource;
  final Uint8List? image;
  final String? filename;
  final String? imageName;
  final String? name;
  AddCourseParams(this.type, this.resource, this.image, this.filename, this.imageName, this.name);
}
