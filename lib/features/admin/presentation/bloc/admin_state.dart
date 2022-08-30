part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  final List<Object?> _props;
  const AdminState(this._props);

  @override
  List<Object?> get props => _props;
}

class AdminInitial extends AdminState {
  final bool creatingNewStudent;
  AdminInitial(this.creatingNewStudent) : super([creatingNewStudent]);
}

class AdminErrorState extends AdminState {
  final String error;
  AdminErrorState(this.error) : super([error]);
}

class AdminLoadedState extends AdminState {
  final Admin admin;
  AdminLoadedState(this.admin) : super([admin]);
}

// To differentite dialog opened mode from normal mode
mixin CourseMode on AdminState {}

class AdminAddingCoursesState extends AdminLoadedState with CourseMode, EquatableMixin {
  final String? name;
  final Uint8List? resource;
  final Uint8List? image;
  final CourseType? type;
  final String? imageName;
  final String? filename;
  AdminAddingCoursesState({
    required Admin admin,
    this.imageName,
    this.filename,
    this.name,
    this.resource,
    this.image,
    this.type,
  }) : super(admin);
  @override
  List<Object?> get props => [
        ...super.props,
        imageName,
        filename,
        name,
        resource,
        image,
        type,
      ];

  AdminAddingCoursesState copyWith({
    String? name,
    Uint8List? resource,
    Uint8List? image,
    CourseType? type,
    String? imageName,
    String? filename,
  }) {
    return AdminAddingCoursesState(
      admin: admin,
      name: name ?? this.name,
      resource: resource ?? this.resource,
      image: image ?? this.image,
      type: type ?? this.type,
      imageName: imageName ?? this.imageName,
      filename: filename ?? this.filename,
    );
  }
}

class CreateCourseInProgress extends AdminLoadedState with CourseMode {
  CreateCourseInProgress(Admin admin) : super(admin);
}

class CoursesCreateSuccessState extends AdminLoadedState with CourseMode {
  CoursesCreateSuccessState(Admin admin) : super(admin);
}

class CoursesCreateFailureState extends AdminLoadedState with CourseMode, EquatableMixin {
  @override
  List<Object?> get props => [...super.props, error];

  final String error;

  CoursesCreateFailureState(Admin admin, this.error) : super(admin);
}
