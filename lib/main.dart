import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam/config/routes/app_router.dart';
import 'package:steam/config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for dependency injection
  // await setup();
  // runApp(MultiBlocProvider(
  //   providers: [
  //     BlocProvider(
  //       create: (_) => locator<HomeBloc>(),
  //     ),
  //     BlocProvider(
  //       create: (_) => locator<DetailBloc>(),
  //     ),
  //     BlocProvider(
  //       create: (_) => locator<AllCryptoBloc>(),
  //     ),
  //   ],
  // child: const MyApp(),
  // ));
  runApp(const MyApp());
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
        supportedLocales: const [Locale('fa', 'IR')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
