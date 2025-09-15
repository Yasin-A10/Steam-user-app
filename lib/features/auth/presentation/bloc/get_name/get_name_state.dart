part of 'get_name_bloc.dart';

@immutable
abstract class GetNameState {}

class GetNameInitial extends GetNameState {}

class GetNameLoading extends GetNameState {}

class GetNameSuccess extends GetNameState {
  final GetNameModel getNameModel;
  GetNameSuccess({required this.getNameModel});
}

class GetNameError extends GetNameState {
  final String message;
  GetNameError({required this.message});
}
