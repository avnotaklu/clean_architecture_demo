import 'package:aptcoder/features/student_dashboard/data/models/view_activity.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/student.dart';
import 'package:aptcoder/features/student_dashboard/domain/entities/view_activity.dart';

class StudentModel extends Student {
  const StudentModel(
      {required super.uid,
      required super.name,
      required super.course,
      required super.institute,
      required super.sem,
      required super.rollNo,
      required super.profilePic,
      required super.lastViewedCourses});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'course': course,
      'institute': institute,
      'sem': sem,
      'rollNo': rollNo,
      'profilePic': profilePic,
      'lastViewedCourses': lastViewedCourses.map((x) => ViewActivityModel(x.resource, x.time).toMap()).toList(),
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      course: map['course'] != null ? map['course'] as String : null,
      institute: map['institute'] != null ? map['institute'] as String : null,
      sem: map['sem'] != null ? map['sem'] as int : null,
      rollNo: map['rollNo'] != null ? map['rollNo'] as int : null,
      profilePic: map['profilePic'] != null ? map['profilePic'] as String : null,
      lastViewedCourses: List<ViewActivity>.from(
        (map['lastViewedCourses'] as List).map<ViewActivity>(
          (data) => ViewActivityModel.fromMap(data),
        ),
      ),
    );
  }
}
