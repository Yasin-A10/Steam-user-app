import 'package:get_it/get_it.dart';
import 'package:steam/core/cities/bloc/cities_bloc.dart';
import 'package:steam/core/cities/data/repository/cities_repository_impl.dart';
import 'package:steam/core/cities/data/source/cities_api_provider.dart';
import 'package:steam/core/cities/domain/repository/cities_repository.dart';
import 'package:steam/core/cities/domain/usecase/cities_usecase.dart';
import 'package:steam/core/network/auth_api_client.dart';
import 'package:steam/features/agencies/data/repository/agencies_repository_impl.dart';
import 'package:steam/features/agencies/data/source/agencies_api_provider.dart';
import 'package:steam/features/agencies/presentation/bloc/agencies_bloc.dart';
import 'package:steam/features/auth/data/repository/login_repository_impl.dart';
import 'package:steam/features/auth/data/repository/logout_repository_impl.dart';
import 'package:steam/features/auth/data/repository/otp_repository_impl.dart';
import 'package:steam/features/auth/data/source/login_api_provider.dart';
import 'package:steam/features/auth/data/source/logout_api_provider.dart';
import 'package:steam/features/auth/data/source/otp_api_provider.dart';
import 'package:steam/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:steam/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:steam/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:steam/features/contact_way/data/repository/update_contact_ripository_impl.dart';
import 'package:steam/features/contact_way/data/source/update_contact.dart';
import 'package:steam/features/contact_way/presentation/bloc/contact_bloc.dart';
import 'package:steam/features/home/data/repository/content_post_repository_impl.dart';
import 'package:steam/features/home/data/source/content_post_api_provider.dart';
import 'package:steam/features/home/presentation/bloc/content_bloc.dart';
import 'package:steam/features/personal_info/data/repository/update_info_repository_impl.dart';
import 'package:steam/features/personal_info/data/source/update_personal_info.dart';
import 'package:steam/features/personal_info/presentation/bloc/personal_info_bloc.dart';
import 'package:steam/features/profile/data/repository/update_resume_repository_impl.dart';
import 'package:steam/features/profile/data/source/update_resume.dart';
import 'package:steam/features/profile/data/source/user_api_provider.dart';
import 'package:steam/features/profile/data/repository/user_repository_impl.dart';
import 'package:steam/features/profile/domain/repository/user_repository.dart';
import 'package:steam/features/profile/domain/usecase/get_user_usecase.dart';
import 'package:steam/features/profile/presentation/bloc/profile_bloc.dart';

GetIt locator = GetIt.instance;

setup() {
  //* for api client
  locator.registerSingleton<AuthApiClient>(AuthApiClient());

  //* API Providers
  locator.registerSingleton<UserApiProvider>(UserApiProvider());
  locator.registerSingleton<ProvinceApiProvider>(ProvinceApiProvider());
  locator.registerSingleton<ProvinceWithCitiesApiProvider>(
    ProvinceWithCitiesApiProvider(),
  );
  locator.registerSingleton<UpdatePersonalInfoApiProvider>(
    UpdatePersonalInfoApiProvider(),
  );
  locator.registerSingleton<UpdateContactApiProvider>(
    UpdateContactApiProvider(),
  );
  locator.registerSingleton<ContentPostApiProvider>(ContentPostApiProvider());
  locator.registerSingleton<UpdateResumeApiProvider>(UpdateResumeApiProvider());
  locator.registerSingleton<AgenciesApiProvider>(AgenciesApiProvider());
  locator.registerSingleton<OtpApiProvider>(OtpApiProvider());
  locator.registerSingleton<LoginApiProvider>(LoginApiProvider());
  locator.registerSingleton<LogoutApiProvider>(LogoutApiProvider());

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
  locator.registerSingleton<UpdateInfoRepositoryImpl>(
    UpdateInfoRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<UpdateContactRepositoryImpl>(
    UpdateContactRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<ContentPostRepositoryImpl>(
    ContentPostRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<UpdateResumeRepositoryImpl>(
    UpdateResumeRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<AgenciesRepositoryImpl>(
    AgenciesRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<OtpRepositoryImpl>(
    OtpRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<LoginRepositoryImpl>(
    LoginRepositoryImpl(apiProvider: locator()),
  );
  locator.registerSingleton<LogoutRepositoryImpl>(
    LogoutRepositoryImpl(apiProvider: locator()),
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
    ProfileBloc(getUserUseCase: locator(), updateResumeRepository: locator()),
  );
  locator.registerSingleton<CitiesBloc>(
    CitiesBloc(
      getCitiesUseCase: locator(),
      getCitiesWithProvinceUseCase: locator(),
    ),
  );
  locator.registerSingleton<PersonalInfoBloc>(
    PersonalInfoBloc(repository: locator()),
  );
  locator.registerSingleton<ContactBloc>(ContactBloc(repository: locator()));
  locator.registerSingleton<ContentBloc>(ContentBloc(repository: locator()));
  locator.registerSingleton<AgenciesBloc>(AgenciesBloc(repository: locator()));
  locator.registerSingleton<OtpBloc>(OtpBloc(repository: locator()));
  locator.registerSingleton<LoginBloc>(LoginBloc(repository: locator()));
  locator.registerSingleton<LogoutBloc>(LogoutBloc(repository: locator()));
}
