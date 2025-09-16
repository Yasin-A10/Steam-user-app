import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:steam/config/routes/route_paths.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:steam/features/about_us/about_us_screen.dart';
import 'package:steam/features/auth/presentation/screen/get_name_screen.dart';
import 'package:steam/features/auth/presentation/screen/login_screen.dart';
import 'package:steam/features/auth/presentation/screen/otp_screen.dart';
import 'package:steam/features/contact_us/screen/contact_us_screen.dart';
import 'package:steam/features/contact_way/presentation/screen/contact_way_screen.dart';
import 'package:steam/features/home/presentation/screen/Image_view_screen.dart';
import 'package:steam/features/home/presentation/screen/Video_player_screen.dart';
import 'package:steam/features/home/presentation/screen/home_screen.dart';
import 'package:steam/features/not_found_screen.dart';
import 'package:steam/features/personal_info/presentation/screen/personal_info_screen.dart';
import 'package:steam/features/profile/presentation/screen/profile_screen.dart';
import 'package:steam/features/profile/presentation/screen/resume_viewer.dart';
import 'package:steam/features/agencies/presentation/screen/agencies_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final List<String> publicRoutes = [
  RoutePaths.login,
  RoutePaths.otp,
  RoutePaths.getName,
];

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RoutePaths.home,
  routes: [
    //! Auth
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.otp,
      builder: (context, state) => OtpScreen(phone: state.extra as String),
    ),
    GoRoute(
      path: RoutePaths.getName,
      builder: (context, state) => const GetNameScreen(),
    ),

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
      builder: (context, state) => const AgenciesScreen(),
    ),
    GoRoute(
      path: RoutePaths.imageViewer,
      builder: (context, state) =>
          ImageViewScreen(imageUrl: state.extra as String),
    ),
    GoRoute(
      path: RoutePaths.videoPlayer,
      builder: (context, state) =>
          VideoPlayerScreen(videoUrl: state.extra as String),
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
    GoRoute(
      path: RoutePaths.resumeViewer,
      builder: (context, state) =>
          PdfViewerScreen(fileUrl: state.extra as String),
    ),
  ],

  //! Redirect
  redirect: (context, state) {
    final isLoggedIn = SessionManager.instance.isLoggedIn();
    final currentPath =
        state.matchedLocation; //! fucking important -> MatchedLocation

    final isPublicRoute = publicRoutes.contains(currentPath);

    if (!isLoggedIn && !isPublicRoute) return '/login';
    if (isLoggedIn && currentPath == '/login') return '/';
    return null;
  },

  //! Not found
  errorBuilder: (context, state) => const NotFoundScreen(),
);
