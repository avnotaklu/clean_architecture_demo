import 'dart:io';
import 'dart:typed_data';

import 'package:aptcoder/core/service/picker_service.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_dashboard/presentation/bloc/student_dashboard_bloc.dart';
import 'package:aptcoder/features/student_profile/domain/usecases/update_profile_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc extends Bloc<StudentProfileEvent, StudentProfileState> {
  final StudentDashboardBloc bloc;
  final UpdateProfileInfo updateProfileInfo;

  StudentProfileBloc(this.bloc, this.updateProfileInfo)
      : assert(bloc.state is StudentLoadedState),
        super(StudentProfileInitial((bloc.state as StudentLoadedState).student)) {
    on<StudentProfileEvent>((event, emit) async {
      if (event is UpdateProfile) {
        final result = await updateProfileInfo(UpdateStudentParams(
            event.student.copyWith(
              course: event.course,
              institute: event.institute,
              sem: event.sem,
              rollNo: event.rollNo,
              profilePic: event.student.profilePic,
            ),
            event.profilePic));
        return result.fold((l) => emit(UpdateFailureState("Failure please try again later", event.student)), (r) {
          bloc.add(FetchStudentEvent());
          emit(UpdateSuccessState(r));
        });
      }

      if (event is EditProfile) {
        emit(EditProfileState(event.label, event.student));
      }

      if (event is EditProfile) {
        emit(EditProfileState(event.label, event.student));
      }

      if (event is CancelUpdateMode) {
        emit(StudentProfileInitial(event.student));
      }
      if (event is ProfilePicUpload) {
        final file = await FileService.pickGalleryImage();
        if (file != null) {
          final bytes = await File(file.path).readAsBytes();
          emit(UpdateProfileProgress(state.student));
          add(UpdateProfile(event.student, profilePic: bytes));
        }
      }
    });
  }
}
