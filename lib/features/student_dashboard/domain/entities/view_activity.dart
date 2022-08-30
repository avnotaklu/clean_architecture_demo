// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class ViewActivity extends Equatable {
  final String resource;
  final Timestamp time;

  const ViewActivity(this.resource, this.time);

  @override
  List<Object?> get props => [resource, time];
}
