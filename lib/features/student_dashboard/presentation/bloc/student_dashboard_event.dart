part of 'student_dashboard_bloc.dart';

abstract class StudentDashboardEvent extends Equatable {
  final List<Object> _props;
  const StudentDashboardEvent(this._props);

  @override
  List<Object> get props => [];
}

class FetchStudentEvent extends StudentDashboardEvent {
  FetchStudentEvent() : super([]);
}

class StudentViewCourse extends StudentDashboardEvent {
  final Student student;
  final Course course;
  StudentViewCourse(this.student, this.course) : super([course, student]);
}
