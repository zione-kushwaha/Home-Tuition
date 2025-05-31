import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/domain/providers/auth_providers.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For now, we'll just use the DashboardScreen directly
    // Once we implement the login flow, we'll uncomment this
    
    // final router = ref.watch(routerProvider);
    
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
    
    // Will replace with this once we have LoginScreen implemented:
    // return MaterialApp.router(
    //   title: AppStrings.appName,
    //   theme: AppTheme.lightTheme,
    //   darkTheme: AppTheme.darkTheme,
    //   themeMode: ThemeMode.system,
    //   routerConfig: router,
    //   debugShowCheckedModeBanner: false,
    // );
  }
}