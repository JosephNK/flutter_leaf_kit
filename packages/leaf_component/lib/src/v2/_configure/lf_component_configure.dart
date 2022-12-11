import 'package:flutter/material.dart';

/// AppBar Configure
class LFAppBarComponentConfigure {
  final TextStyle? titleStyle;
  final double? backIconSize;

  LFAppBarComponentConfigure({
    this.titleStyle,
    this.backIconSize,
  });
}

class LFComponentConfigure {
  static final LFComponentConfigure _instance =
      LFComponentConfigure._internal();
  static LFComponentConfigure get shared => _instance;
  LFComponentConfigure._internal();

  void setup({
    required LFAppBarComponentConfigure appBarConfigure,
  }) {
    _appBar = appBarConfigure;
  }

  LFAppBarComponentConfigure? get appBar => LFComponentConfigure.shared._appBar;
  LFAppBarComponentConfigure? _appBar;
}
