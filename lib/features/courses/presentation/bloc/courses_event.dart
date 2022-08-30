part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  final List<Object> _props;
  const CoursesEvent(this._props);

  @override
  List<Object> get props => _props;
}

class LoadCoursesEvent extends CoursesEvent {
  LoadCoursesEvent() : super([]);
}
