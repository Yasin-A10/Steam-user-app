import 'package:get_it/get_it.dart';
import 'package:steam/core/cities/bloc/cities_bloc.dart';
import 'package:steam/core/cities/data/repository/cities_repository_impl.dart';
import 'package:steam/core/cities/data/source/cities_api_provider.dart';
import 'package:steam/core/cities/domain/repository/cities_repository.dart';
import 'package:steam/core/cities/domain/usecase/cities_usecase.dart';
import 'package:steam/features/profile/data/source/user_api_provider.dart';
import 'package:steam/features/profile/data/repository/user_repository_impl.dart';
import 'package:steam/features/profile/domain/repository/user_repository.dart';
import 'package:steam/features/profile/domain/usecase/get_user_usecase.dart';
import 'package:steam/features/profile/presentation/bloc/profile_bloc.dart';

GetIt locator = GetIt.instance;

setup() {
  locator.registerSingleton<UserApiProvider>(UserApiProvider());
  locator.registerSingleton<ProvinceApiProvider>(ProvinceApiProvider());
  locator.registerSingleton<ProvinceWithCitiesApiProvider>(
    ProvinceWithCitiesApiProvider(),
  );

  //* Repository
  locator.registerSingleton<UserRepository>(
    UserRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<CitiesRepository>(
    CitiesRepositoryImpl(
      provinceApiProvider: locator(),
      provinceWithCitiesApiProvider: locator(),
    ),
  );

  //* UseCase
  locator.registerSingleton<GetUserUseCase>(
    GetUserUseCase(userRepository: locator()),
  );
  locator.registerSingleton<GetCitiesUseCase>(
    GetCitiesUseCase(citiesRepository: locator()),
  );
  locator.registerSingleton<GetCitiesWithProvinceUseCase>(
    GetCitiesWithProvinceUseCase(citiesRepository: locator()),
  );

  //* Bloc
  locator.registerSingleton<ProfileBloc>(
    ProfileBloc(getUserUseCase: locator()),
  );
  locator.registerSingleton<CitiesBloc>(
    CitiesBloc(
      getCitiesUseCase: locator(),
      getCitiesWithProvinceUseCase: locator(),
    ),
  );
}
