part of 'content_bloc.dart';

@immutable
abstract class ContentState {}

class ContentLoading extends ContentState {}

class ContentSuccess extends ContentState {
  final ContentPostModel contentPostModel;
  ContentSuccess({required this.contentPostModel});
}

class ContentError extends ContentState {
  final String message;
  ContentError({required this.message});
}
