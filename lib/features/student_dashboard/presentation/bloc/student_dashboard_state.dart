part of 'student_dashboard_bloc.dart';

abstract class StudentDashboardState extends Equatable {
  final List<Object> _props;
  const StudentDashboardState(this._props);

  @override
  List<Object> get props => _props;
}

class StudentDashboardInitial extends StudentDashboardState {
  final bool creatingNewStudent;
  StudentDashboardInitial(this.creatingNewStudent) : super([creatingNewStudent]);
}

class StudentErrorState extends StudentDashboardState {
  final String error;
  StudentErrorState(this.error) : super([error]);
}

class StudentViewCourseErrorState extends StudentDashboardState {
  final String error;
  StudentViewCourseErrorState(this.error) : super([error]);
}

class StudentLastCoursesErrorState extends StudentDashboardState {
  final String error;
  StudentLastCoursesErrorState(this.error) : super([error]);
}

class StudentLoadedState extends StudentDashboardState {
  final Student student;
  final List<Course> viewedCourses;
  StudentLoadedState(this.student, this.viewedCourses) : super([student, ...viewedCourses]);
}
