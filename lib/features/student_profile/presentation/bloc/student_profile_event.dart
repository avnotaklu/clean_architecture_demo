part of 'student_profile_bloc.dart';

abstract class StudentProfileEvent extends Equatable {
  final List<Object?> _props;
  final Student student;
  const StudentProfileEvent(this._props, this.student);

  @override
  List<Object?> get props => _props;
}

class UpdateProfile extends StudentProfileEvent {
  final String? course;
  final String? institute;
  final int? sem;
  final int? rollNo;
  final Uint8List? profilePic;
  final String? name;

  UpdateProfile(Student student, {this.course, this.institute, this.sem, this.rollNo, this.profilePic, this.name})
      : assert(
            course != null || institute != null || sem != null || rollNo != null || profilePic != null || name != null),
        super([
          course,
          institute,
          sem,
          rollNo,
          profilePic,
          name,
        ], student);
}

class EditProfile extends StudentProfileEvent {
  final String label;
  EditProfile(this.label, Student student) : super([label], student);
}

class CancelUpdateMode extends StudentProfileEvent {
  CancelUpdateMode(student) : super([], student);
}

class ProfilePicUpload extends StudentProfileEvent {
  ProfilePicUpload(student) : super([], student);
}

