import 'package:flutter/material.dart';
import 'package:flutter_leaf_common/leaf_common.dart';

class LFDataItem extends Equatable {
  final dynamic id;
  final String text;
  final dynamic option;
  final LFDataColorItem? color;
  final Widget? leading;

  const LFDataItem({
    required this.id,
    required this.text,
    this.option,
    this.color,
    this.leading,
  });

  @override
  List<Object?> get props => [
        id,
        text,
      ];

  @override
  bool operator ==(other) =>
      other is LFDataItem && id == other.id && text == other.text;

  @override
  int get hashCode => hash2(id.hashCode, text.hashCode);
}

class LFDataColorItem extends Equatable {
  final Color? normal;
  final Color? selected;

  const LFDataColorItem({
    this.normal,
    this.selected,
  });

  @override
  List<Object?> get props => [
        normal,
        selected,
      ];
}
