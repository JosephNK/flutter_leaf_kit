import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';

/// Wraps a widget with [MaterialApp] and [LeafTheme] for testing.
///
/// Optionally accepts a custom [LeafThemeData]. Defaults to [LeafThemeData.light()].
Widget wrapWithTheme(Widget child, {LeafThemeData? theme}) {
  return MaterialApp(
    home: LeafTheme(
      data: theme ?? LeafThemeData.light(),
      child: Scaffold(body: child),
    ),
  );
}
