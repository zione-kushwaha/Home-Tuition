import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/domain/providers/auth_state_provider.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';

/// Routes names
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String jobDetails = '/jobs/:id';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String questions = '/questions';
  static const String questionDetails = '/questions/:id';
}

/// App router configuration using GoRouter
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.dashboard,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final isLoginRoute = state.matchedLocation == AppRoutes.login || 
                           state.matchedLocation == AppRoutes.register || 
                           state.matchedLocation == AppRoutes.forgotPassword;
                           
      if (!isLoggedIn && !isLoginRoute) {
        // Redirect to login if trying to access protected routes while not logged in
        return AppRoutes.login;
      } else if (isLoggedIn && isLoginRoute) {
        // Redirect to dashboard if already logged in and trying to access auth routes
        return AppRoutes.dashboard;
      }
      
      // No redirect needed
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      // Add more routes as they're implemented
      // GoRoute(
      //   path: AppRoutes.login,
      //   builder: (context, state) => const LoginScreen(),
      // ),
    ],
  );
});