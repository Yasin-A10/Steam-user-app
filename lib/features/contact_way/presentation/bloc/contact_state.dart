part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {
  final ContactModel contactModel;
  ContactSuccess({required this.contactModel});
}

class ContactError extends ContactState {
  final String message;
  ContactError({required this.message});
}
