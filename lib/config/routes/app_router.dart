// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:steam/config/routes/route_paths.dart';
import 'package:steam/features/home/presentation/screen/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.home,
  routes: [
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  //* errorBuilder: (context, state) => const NotFoundScreen(),
);
