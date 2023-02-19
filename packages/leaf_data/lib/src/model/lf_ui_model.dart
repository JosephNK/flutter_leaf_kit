part of leaf_data;

class UIModel extends Equatable {
  final Object? id;
  final Object? data;

  const UIModel({
    required this.id,
    required this.data,
  });

  @override
  List<Object?> get props => [
        id,
        data,
      ];
}
