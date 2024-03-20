import 'package:flutter/material.dart';
import 'package:flutter_test_application/ui/navigation/main_navigation.dart';
import 'package:flutter_test_application/ui/theme/main_theme.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      theme: MainTheme.mainTheme,
    );
  }
}
