import 'package:aptcoder/features/student_dashboard/domain/entities/view_activity.dart';

class ViewActivityModel extends ViewActivity {
  const ViewActivityModel(super.resource, super.time);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'resource': resource, 'time': time};
  }

  factory ViewActivityModel.fromMap(Map<String, dynamic> map) {
    return ViewActivityModel(map['resource'] as String, map['time']);
  }
}
