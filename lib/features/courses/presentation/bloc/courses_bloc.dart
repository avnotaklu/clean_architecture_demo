import 'package:aptcoder/core/empty_params.dart';
import 'package:aptcoder/features/courses/domain/entities/course.dart';
import 'package:aptcoder/features/courses/domain/usecases/get_all_courses_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetAllCourses getAllCourses;
  CoursesBloc(this.getAllCourses) : super(CoursesInitial()) {
    on<CoursesEvent>((event, emit) async {
      if (event is LoadCoursesEvent) {
        final courses = await getAllCourses(EmptyParams());
        courses.fold((l) {
          emit(CoursesLoadingErrorState("Some error occured"));
        }, (r) => emit(CoursesLoadedState(r)));
      }
    });
  }
}
