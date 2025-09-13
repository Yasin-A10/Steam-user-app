part of 'agencies_bloc.dart';

@immutable
abstract class AgenciesState {}

class AgenciesLoading extends AgenciesState {}

class AgenciesSuccess extends AgenciesState {
  final AgenciesModel agenciesModel;
  AgenciesSuccess({required this.agenciesModel});
}

class AgenciesError extends AgenciesState {
  final String message;
  AgenciesError({required this.message});
}
