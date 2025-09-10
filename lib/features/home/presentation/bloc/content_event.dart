part of 'content_bloc.dart';

abstract class ContentEvent {}

class LoadContentEvent extends ContentEvent {
  final int page;
  final int pageSize;

  LoadContentEvent({required this.page, required this.pageSize});
}
