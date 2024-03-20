import 'package:flutter/material.dart';

abstract class MainTheme {
  static final mainTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    useMaterial3: true,
  );
}
