part of 'agencies_bloc.dart';

abstract class AgenciesEvent {}

class LoadAgencies extends AgenciesEvent {
  final int cityId;
  LoadAgencies({required this.cityId});
}
