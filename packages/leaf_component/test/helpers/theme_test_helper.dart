import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';

/// Wraps a widget with [MaterialApp] and [LFTheme] for testing.
///
/// Optionally accepts a custom [LFThemeData]. Defaults to [LFThemeData.light()].
Widget wrapWithTheme(Widget child, {LFThemeData? theme}) {
  return MaterialApp(
    home: LFTheme(
      data: theme ?? LFThemeData.light(),
      child: Scaffold(body: child),
    ),
  );
}
