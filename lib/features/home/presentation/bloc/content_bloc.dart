import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:steam/features/home/data/model/content_post_model.dart';
import 'package:steam/features/home/data/repository/content_post_repository_impl.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentPostRepositoryImpl repository;

  ContentBloc({required this.repository}) : super(ContentLoading()) {
    on<LoadContentEvent>((event, emit) async {
      emit(ContentLoading());

      try {
        final Either<String, ContentPostModel> result = await repository
            .getContentPost(event.page, event.pageSize);

        result.fold(
          (error) => emit(ContentError(message: error)),
          (contentPostModel) =>
              emit(ContentSuccess(contentPostModel: contentPostModel)),
        );
      } catch (e) {
        emit(ContentError(message: 'Unexpected error: ${e.toString()}'));
      }
    });
  }
}
