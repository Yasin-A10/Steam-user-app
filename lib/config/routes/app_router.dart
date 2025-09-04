// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:steam/config/routes/route_paths.dart';
import 'package:steam/features/about_us/about_us_screen.dart';
import 'package:steam/features/contact_us/screen/contact_us_screen.dart';
import 'package:steam/features/contact_way/presentation/screen/contact_way_screen.dart';
import 'package:steam/features/home/presentation/screen/home_screen.dart';
import 'package:steam/features/personal_info/presentation/screen/personal_info_screen.dart';
import 'package:steam/features/profile/presentation/screen/profile_screen.dart';
import 'package:steam/features/representative/presentation/screen/representative_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.home,
  routes: [
    //! Main
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RoutePaths.aboutUs,
      builder: (context, state) => const AboutUsScreen(),
    ),
    GoRoute(
      path: RoutePaths.contactUs,
      builder: (context, state) => const ContactUsScreen(),
    ),
    GoRoute(
      path: RoutePaths.representative,
      builder: (context, state) => const RepresentativeScreen(),
    ),

    //! Profile
    GoRoute(
      path: RoutePaths.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: RoutePaths.personalInfo,
      builder: (context, state) => const PersonalInfoScreen(),
    ),
    GoRoute(
      path: RoutePaths.contactWay,
      builder: (context, state) => const ContactWayScreen(),
    ),
  ],
  //* errorBuilder: (context, state) => const NotFoundScreen(),
);
