import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:steam/features/agencies/data/model/agencies_model.dart';
import 'package:steam/features/agencies/data/repository/agencies_repository_impl.dart';

part 'agencies_state.dart';
part 'agencies_event.dart';

class AgenciesBloc extends Bloc<AgenciesEvent, AgenciesState> {
  final AgenciesRepositoryImpl repository;

  AgenciesBloc({required this.repository}) : super(AgenciesLoading()) {
    on<LoadAgencies>((event, emit) async {
      emit(AgenciesLoading());

      Either<String, AgenciesModel> result = await repository.fetchAgencies(
        cityId: event.cityId,
      );

      result.fold(
        (left) => emit(AgenciesError(message: left)),
        (right) => emit(AgenciesSuccess(agenciesModel: right)),
      );
    });
  }
}
