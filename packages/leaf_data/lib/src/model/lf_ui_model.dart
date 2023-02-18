part of leaf_data;

class UIModel extends Equatable {
  final Object? data;

  const UIModel({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];
}
