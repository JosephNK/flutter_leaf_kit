part of leaf_bloc;

class UIModel<T> extends Equatable {
  final T? id;

  const UIModel({
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
