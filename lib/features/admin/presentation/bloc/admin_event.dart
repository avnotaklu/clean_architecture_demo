part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  final List<Object?> _props;
  const AdminEvent(this._props);

  @override
  List<Object?> get props => _props;
}

class FetchAdminEvent extends AdminEvent {
  FetchAdminEvent() : super([]);
}

class AdminAddingCoursesEvent extends AdminEvent {
  AdminAddingCoursesEvent() : super([]);
}

class ResourceLoadEvent extends AdminEvent {
  ResourceLoadEvent() : super([]);
}

class ImageLoadEvent extends AdminEvent {
  ImageLoadEvent() : super([]);
}

class TypeChangeEvent extends AdminEvent {
  final CourseType type;

  TypeChangeEvent(this.type) : super([type]);
}

class CreateCourseRequestedEvent extends AdminEvent {
  final CourseType? type;
  final Uint8List? resource;
  final Uint8List? image;
  final String? filename;
  final String? imageName;
  final String? name;

  CreateCourseRequestedEvent(
      {required this.type,
      required this.resource,
      required this.image,
      required this.filename,
      required this.imageName,
      required this.name})
      : super([type, resource, image, filename, imageName, name]);
}

class CreateCourseDispatchEvent extends CreateCourseRequestedEvent {
  CreateCourseDispatchEvent(
      {required super.type,
      required super.resource,
      required super.image,
      required super.filename,
      required super.imageName,
      required super.name});
}
