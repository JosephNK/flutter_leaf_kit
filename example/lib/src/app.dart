import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import 'features/home/home_screen.dart';
import 'theme/app_theme.dart';

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  bool _isDark = false;

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _isDark ? AppTheme.dark() : AppTheme.light();

    return LFTheme(
      data: themeData,
      child: MaterialApp(
        title: 'Leaf Kit V2 Example',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: _isDark ? Brightness.dark : Brightness.light,
          colorSchemeSeed: themeData.colors.primary,
        ),
        home: HomeScreen(
          isDark: _isDark,
          onToggleTheme: _toggleTheme,
        ),
      ),
    );
  }
}
