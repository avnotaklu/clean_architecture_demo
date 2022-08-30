import 'dart:io';
import 'dart:typed_data';

import 'package:aptcoder/core/error/failures.dart';
import 'package:aptcoder/core/service/picker_service.dart';
import 'package:aptcoder/features/admin/domain/entities/admin.dart';
import 'package:aptcoder/features/admin/domain/usecases/add_course.dart';
import 'package:aptcoder/features/admin/domain/usecases/get_admin_info.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:aptcoder/features/login/presentation/bloc/authentication_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AuthenticationBloc _authenticationBloc;
  final GetAdminInfo getAdminInfo;
  final AddCourse addCourse;
  AdminBloc(this._authenticationBloc, this.getAdminInfo, this.addCourse)
      : assert(_authenticationBloc.state is AuthorizedState),
        super(AdminInitial((_authenticationBloc.state as AuthorizedState).user.isNewUser)) {
    on<AdminEvent>((event, emit) async {
      if (event is FetchAdminEvent) {
        final info = await getAdminInfo.call(GetAdminParams((_authenticationBloc.state as AuthorizedState).user));
        info.fold((l) => emit(AdminErrorState("There was an error")), (r) => emit(AdminLoadedState(r)));
      }

      if (event is AdminAddingCoursesEvent) {
        if (state is AdminLoadedState) {
          emit(AdminAddingCoursesState(admin: (state as AdminLoadedState).admin));
        }
      }

      if (event is CreateCourseDispatchEvent) {
        final admin = (state as AdminLoadedState).admin;
        final value = await addCourse(
            AddCourseParams(event.type, event.resource, event.image, event.filename, event.imageName, event.name));
        value.fold((l) {
          String error = "Unexpected Error";
          if (l is NullFailure) {
            error = "Please Enter all fields";
          }
          emit(CoursesCreateFailureState(admin, error));
        }, (r) {
          emit(CoursesCreateSuccessState(admin));
        });
      } else if (event is CreateCourseRequestedEvent && state is! CreateCourseDispatchEvent) {
        final admin = (state as AdminLoadedState).admin;
        add(CreateCourseDispatchEvent(
            type: event.type,
            resource: event.resource,
            image: event.image,
            filename: event.filename,
            imageName: event.imageName,
            name: event.name));
        emit(CreateCourseInProgress(admin));
      } else if (event is ResourceLoadEvent) {
        try {
          final String allowedFileType;
          switch ((state as AdminAddingCoursesState).type!) {
            case CourseType.video:
              allowedFileType = "mp4";
              break;
            case CourseType.ppt:
              allowedFileType = "ppt";
              break;
            case CourseType.pdf:
              allowedFileType = "pdf";
              break;
          }

          final file = await FileService.pickFile([allowedFileType]);
          final bytes = file?.path != null ? await File(file!.path!).readAsBytes() : null;
          emit((state as AdminAddingCoursesState).copyWith(resource: bytes, filename: file?.name));
        } catch (e) {
          emit(CoursesCreateFailureState((state as AdminAddingCoursesState).admin, "Please enter type first"));
        }
      } else if (event is ImageLoadEvent) {
        final file = await FileService.pickGalleryImage();
        final bytes = file?.path == null ? null : await File(file!.path).readAsBytes();
        emit((state as AdminAddingCoursesState).copyWith(image: bytes, imageName: file?.name));
      } else if (event is TypeChangeEvent) {
        emit((state as AdminAddingCoursesState).copyWith(type: event.type));
      }
    });
  }
}
