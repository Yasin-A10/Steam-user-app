import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam/config/routes/app_router.dart';
import 'package:steam/config/theme/app_theme.dart';
import 'package:steam/core/cities/bloc/cities_bloc.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:steam/features/agencies/presentation/bloc/agencies_bloc.dart';
import 'package:steam/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:steam/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:steam/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:steam/features/auth/presentation/bloc/get_name/get_name_bloc.dart';
import 'package:steam/features/contact_way/presentation/bloc/contact_bloc.dart';
import 'package:steam/features/personal_info/presentation/bloc/personal_info_bloc.dart';
import 'package:steam/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:steam/features/home/presentation/bloc/content_bloc.dart';
import 'package:steam/locator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* for dependency injection
  await setup();

  //* for shared_preferences
  await SessionManager.instance.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<ProfileBloc>()),
        BlocProvider(create: (_) => locator<CitiesBloc>()),
        BlocProvider(create: (_) => locator<PersonalInfoBloc>()),
        BlocProvider(create: (_) => locator<ContactBloc>()),
        BlocProvider(create: (_) => locator<ContentBloc>()),
        BlocProvider(create: (_) => locator<AgenciesBloc>()),
        BlocProvider(create: (_) => locator<OtpBloc>()),
        BlocProvider(create: (_) => locator<LoginBloc>()),
        BlocProvider(create: (_) => locator<LogoutBloc>()),
        BlocProvider(create: (_) => locator<GetNameBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        locale: Locale('fa', 'IR'),
        supportedLocales: const [Locale('fa', 'IR'), Locale('en', 'US')],
        localizationsDelegates: [
          PersianMaterialLocalizations.delegate,
          PersianCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
