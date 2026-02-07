part of '../model.dart';

/// LeafDataItem
class LeafDataItem extends Equatable {
  final dynamic id;
  final String text;
  final dynamic option;
  final LeafDataColorItem? color;
  final Widget? leading;

  const LeafDataItem({
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
      other is LeafDataItem && id == other.id && text == other.text;

  @override
  int get hashCode => hash2(id.hashCode, text.hashCode);
}

/// LeafDataColorItem
class LeafDataColorItem extends Equatable {
  final Color? normal;
  final Color? selected;

  const LeafDataColorItem({
    this.normal,
    this.selected,
  });

  @override
  List<Object?> get props => [
        normal,
        selected,
      ];
}
