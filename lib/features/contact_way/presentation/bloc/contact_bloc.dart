import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:steam/features/contact_way/data/model/contact_model.dart';
import 'package:steam/features/contact_way/data/repository/update_contact_ripository_impl.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final UpdateContactRepositoryImpl repository;

  ContactBloc({required this.repository}) : super(ContactInitial()) {
    on<LoadContactEvent>((event, emit) {
      emit(ContactInitial());
    });

    on<UpdateContactEvent>(_onUpdateContact);
  }

  Future<void> _onUpdateContact(
    UpdateContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactLoading());

    try {
      final Either<String, ContactModel> result = await repository
          .updateContact(event.userInfo);

      result.fold(
        (error) => emit(ContactError(message: error)),
        (contactModel) => emit(ContactSuccess(contactModel: contactModel)),
      );
    } catch (e) {
      emit(ContactError(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
