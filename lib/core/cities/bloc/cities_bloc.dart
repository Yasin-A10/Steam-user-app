import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:steam/core/cities/domain/entity/cities_entity.dart';
import 'package:steam/core/cities/domain/usecase/cities_usecase.dart';
import 'package:steam/core/cities/bloc/cities_status.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final GetCitiesUseCase getCitiesUseCase;
  final GetCitiesWithProvinceUseCase getCitiesWithProvinceUseCase;

  CitiesBloc({
    required this.getCitiesUseCase,
    required this.getCitiesWithProvinceUseCase,
  }) : super(
         CitiesState(
           provincesStatus: ProvincesLoading(),
           provincesWithCitiesStatus: ProvincesWithCitiesLoading(),
         ),
       ) {
    //! for provinces
    on<LoadProvincesEvent>((event, emit) async {
      // emit loading state
      emit(state.copyWith(newProvincesStatus: ProvincesLoading()));

      // call use case
      Either<String, List<ProvinceEntity>> dataState = await getCitiesUseCase();

      // emit error or success state
      dataState.fold(
        (left) => emit(
          state.copyWith(newProvincesStatus: ProvincesError(message: left)),
        ),
        (right) => emit(
          state.copyWith(
            newProvincesStatus: ProvincesSuccess(provinces: right),
          ),
        ),
      );
    });

    //! for province with cities
    on<LoadProvincesWithCitiesEvent>((event, emit) async {
      // emit loading state
      emit(
        state.copyWith(
          newProvincesWithCitiesStatus: ProvincesWithCitiesLoading(),
        ),
      );

      // call use case
      Either<String, List<ProvinceWithCitiesEntity>> dataState =
          await getCitiesWithProvinceUseCase(provinceId: event.provinceId);

      // emit error or success state
      dataState.fold(
        (left) => emit(
          state.copyWith(
            newProvincesWithCitiesStatus: ProvincesWithCitiesError(
              message: left,
            ),
          ),
        ),
        (right) => emit(
          state.copyWith(
            newProvincesWithCitiesStatus: ProvincesWithCitiesSuccess(
              provincesWithCities: right,
            ),
          ),
        ),
      );
    });
  }
}
