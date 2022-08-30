part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState(this._props);

  final List<Object> _props;

  @override
  List<Object> get props => _props;
}

class CoursesInitial extends CoursesState {
  CoursesInitial() : super([]);
}

class CoursesLoadedState extends CoursesState {
  final List<Course> courses;

  CoursesLoadedState(this.courses) : super([courses]);
}

class CoursesLoadingErrorState extends CoursesState {
  final String error;

  CoursesLoadingErrorState(this.error) : super([error]);
}
