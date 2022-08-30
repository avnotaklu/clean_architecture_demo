import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  Failure(this.properties);

  @override
  List<Object?> get props => properties;
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure() : super([]);
}

class NullFailure extends Failure {
  NullFailure() : super([]);
}
