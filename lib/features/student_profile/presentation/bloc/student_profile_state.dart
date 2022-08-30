part of 'student_profile_bloc.dart';

abstract class StudentProfileState extends Equatable {
  final List<Object?> _props;
  final Student student;

  const StudentProfileState(this.student, this._props);
  @override
  List<Object?> get props => _props + [student];
}

class StudentProfileInitial extends StudentProfileState {
  StudentProfileInitial(student) : super(student, []);
}

class UpdateProfileProgress extends StudentProfileState {
  UpdateProfileProgress(student) : super(student, []);
}

class UpdateFailureState extends StudentProfileState {
  final String error;

  UpdateFailureState(this.error, student) : super(student, []);
}

class UpdateSuccessState extends StudentProfileState {
  UpdateSuccessState(student) : super(student, []);
}

class EditProfileState extends StudentProfileState {
  final String label;

  EditProfileState(this.label, student) : super(student, []);
}
