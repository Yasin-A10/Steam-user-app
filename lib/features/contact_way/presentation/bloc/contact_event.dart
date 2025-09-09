part of 'contact_bloc.dart';

abstract class ContactEvent {}

class LoadContactEvent extends ContactEvent {}

class UpdateContactEvent extends ContactEvent {
  final ContactModel userInfo;

  UpdateContactEvent({required this.userInfo});
}
