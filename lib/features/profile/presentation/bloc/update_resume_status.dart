import 'package:flutter/material.dart';
import 'package:steam/features/profile/data/model/update_resume_model.dart';

@immutable
abstract class ResumeStatus {}

class ResumeInitial extends ResumeStatus {}

class ResumeLoading extends ResumeStatus {}

class ResumeSuccess extends ResumeStatus {
  final UpdateResumeModel updateResumeModel;
  final bool isDeleted;
  ResumeSuccess({required this.updateResumeModel, required this.isDeleted});
}

class ResumeError extends ResumeStatus {
  final String message;
  ResumeError({required this.message});
}
