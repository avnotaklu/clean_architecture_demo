// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:aptcoder/features/student_dashboard/domain/entities/view_activity.dart';

class NewStudent extends Student {
  // NOTE: should not be derived by model
  NewStudent.fromStudent(Student student) : super.fromStudent(student);
}

class Student extends Equatable {
  final String uid;
  final String name;
  final String? course;
  final String? institute;
  final int? sem;
  final int? rollNo;
  final String? profilePic;
  final List<ViewActivity> lastViewedCourses;

  Student.fromStudent(Student other)
      : uid = other.uid,
        name = other.name,
        course = other.course,
        institute = other.institute,
        sem = other.sem,
        rollNo = other.rollNo,
        profilePic = other.profilePic,
        lastViewedCourses = other.lastViewedCourses;

  const Student(
      {required this.uid,
      required this.name,
      required this.course,
      required this.institute,
      required this.sem,
      required this.rollNo,
      required this.profilePic,
      required this.lastViewedCourses});
  @override
  List<Object?> get props => [
        uid,
        name,
        course,
        institute,
        sem,
        rollNo,
        profilePic,
        ...lastViewedCourses,
      ];

  Student copyWith({
    String? uid,
    String? name,
    String? course,
    String? institute,
    int? sem,
    int? rollNo,
    String? profilePic,
    List<ViewActivity>? lastViewedCourses,
  }) {
    return Student(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      course: course ?? this.course,
      institute: institute ?? this.institute,
      sem: sem ?? this.sem,
      rollNo: rollNo ?? this.rollNo,
      profilePic: profilePic ?? this.profilePic,
      lastViewedCourses: lastViewedCourses ?? this.lastViewedCourses,
    );
  }
}
